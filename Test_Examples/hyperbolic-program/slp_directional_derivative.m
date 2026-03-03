%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% returns the striaght-line program of the dirctional derivative 
%% of a given polynomial. 

%% Copyright (c) 2025, by
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [nodes, out_id] = slp_directional_derivative(poly, d)
% Build an SLP (struct format) that computes the directional derivative
% D_d p(x) = grad p(x)' * d for a scalar polynomial p given by SLP `poly`.
%
% INPUTS
%   poly : struct array with fields .id, .op in {'add','sub','mul','pow'},
%          .in = [i j] (0 means f0=1), .coef (scalar)
%   d    : n-by-1 direction vector; variables are x_1..x_n with ids 1..n
%
% OUTPUTS
%   nodes : struct SLP that first computes the primal p (copy of `poly`),
%           then computes the derivative nodes; the last node is D_d p(x).
%   out_id: id of the last node (directional derivative)
%
% Notes:
% - We append a copy of the primal SLP so derivative rules can reference f_i.
% - Base rules:
%     D_d f0 = 0,
%     D_d x_j = d_j.
% - Chain rules:
%     add: f = a*(fi + fj)   -> g = a*(gi + gj)
%     sub: f = a*(fi - fj)   -> g = a*(gi - gj)
%     mul: f = a*(fi * fj)   -> g = a*(fi*gj + fj*gi)
%     pow: f = a*(fi^e)      -> g = a*e*(fi^(e-1))*gi   (e integer)
%
% This produces an SLP of size O(|poly|), much smaller than building a full
% gradient SLP (size ~ n*|poly|).

    n = numel(d);                % # variables x_1..x_n
    m = numel(poly);

    % -------- storage and id management --------
    nodes = struct('id', {}, 'op', {}, 'in', {}, 'coef', {});
    next_id = n;                 % variables occupy ids 1..n

    % Append helper
    function nid = add_node(opstr, a, b, coef)
        next_id = next_id + 1;
        nodes(end+1).id   = uint32(next_id);
        nodes(end  ).op   = opstr;
        nodes(end  ).in   = uint32([a, b]);
        nodes(end  ).coef = coef;
        nid = double(next_id);
    end

    % ------- Phase 0: constants used in derivative graph -------
    % Zero constant node (0 * f0)
    zero_id = add_node('mul', 0, 0, 0);
    % D_d x_j = d_j constants
    dconst_id = zeros(n,1);
    for j = 1:n
        dconst_id(j) = add_node('mul', 0, 0, d(j));
    end

    % ------- Phase 1: copy the primal SLP so fi are available -------
    % Map old poly ids -> new ids in `nodes`
    old2new = containers.Map('KeyType','uint32','ValueType','uint32');
    for r = 1:m
        a = uint32(poly(r).in(1));
        b = uint32(poly(r).in(2));

        % map inputs: 0 stays 0; 1..n are variables; >n are previous nodes
        na = map_input(a);
        nb = map_input(b);

        new_id = add_node(poly(r).op, na, nb, poly(r).coef);
        old2new(uint32(poly(r).id)) = uint32(new_id);
    end
    % helper: after old2new exists for previous nodes
    function out = map_old(idu)
        if idu <= n
            out = double(idu);       % variable id
        else
            out = double(old2new(uint32(idu)));
        end
    end
    function out = map_input(idu)
        if idu == 0
            out = 0;
        elseif idu <= n
            out = double(idu);
        else
            % must have been added already (topological order)
            out = double(old2new(uint32(idu)));
        end
    end

    % ------- Phase 2: build derivative nodes g_i forward -------
    % We will store, for each id (0, 1..n, copied nodes), the id of its
    % directional derivative node g_i.
    max_id_after_primal = next_id;      % last id after copying primal
    g_id = containers.Map('KeyType','uint32','ValueType','uint32');

    % base cases
    g_id(uint32(0)) = uint32(zero_id);
    for j = 1:n
        g_id(uint32(j)) = uint32(dconst_id(j));  % D_d x_j = d_j
    end

    % iterate through copied primal nodes in the same order
    for r = 1:m
        % new node id for this primal op:
        u = old2new(uint32(poly(r).id));       % uint32
        u = double(u);

        % inputs (mapped into the copied primal)
        a_old = poly(r).in(1); b_old = poly(r).in(2);
        ia = map_old(double(a_old));
        ib = map_old(double(b_old));

        % derivative inputs (must already exist)
        ga = double(g_id(uint32(double(a_old))));
        gb = double(g_id(uint32(double(b_old))));

        op  = poly(r).op;
        cof = poly(r).coef;

        switch op
            case 'add'     % g = cof*(ga + gb)
                sum_id = add_node('add', ga, gb, 1);
                gu     = add_node('mul', sum_id, 0, cof);

            case 'sub'     % g = cof*(ga - gb)
                diff_id = add_node('sub', ga, gb, 1);
                gu      = add_node('mul', diff_id, 0, cof);

            case 'mul'     % g = cof*(fa*gb + fb*ga)
                % fa, fb are the copied primal inputs (ia, ib)
                t1 = add_node('mul', ia, gb, 1);   % fa * gb
                t2 = add_node('mul', ib, ga, 1);   % fb * ga
                s  = add_node('add', t1, t2, 1);
                gu = add_node('mul', s, 0, cof);

            case 'pow'     % f = cof*(fa^e) -> g = cof*e*(fa^(e-1))*ga
                e = double(b_old);     % exponent stored in .in(2)
                if e == 0
                    % f = cof*1, derivative 0
                    gu = zero_id;
                else
                    if e == 1
                        % f = cof*fa, g = cof*ga
                        gu = add_node('mul', ga, 0, cof);
                    else
                        p  = add_node('pow', ia, e-1, 1);            % fa^(e-1)
                        gu = add_node('mul', p, 0, cof*e);           % cof*e * (fa^(e-1))
                        gu = add_node('mul', gu, ga, 1);             % * ga
                    end
                end

            otherwise
                error('Unsupported op: %s', op);
        end

        g_id(uint32(poly(r).id)) = uint32(gu);
    end

    % The derivative of the final output node:
    out_id = double(g_id(uint32(poly(end).id)));
end
