%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Projecting on a hyperbolicty cone using DDS.
%% Comparing DDS and Frank-Wolf

%% Copyright (c) 2025, by
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% By running this function, the code solves the projection problem as
% describes in the function hyper_proj_DDS using both FW and DDS. The FW
% code is from the paper 
%     "Projection onto hyperbolicity cones and beyond: a dual Frank-Wolfe approach"
% by Takayuki Nagano, Bruno F. Lourenço and Akiko Takeda.
% The parameters (n,k) of the elemetary symmetric polynomials are given in
% the matrix NK. 


 clearvars Z A b cons;

 NK=[  20   5;  
       20   10;
       20   15;
       50   10;
       50   25;
       50   30;
       100  10;
       100  20;
       100  30;
       200  10;
       200  20;
       200  30;
       500  10;
       500  20;
       500  30;
       1000 10;
       1000 20;
       1000 30
    ];


if ~exist('scriptDir_table', 'var')
    scriptDir_table = fileparts(mfilename('fullpath'));   
 end

outfile = fullfile(scriptDir_table,  'Table-2.txt');
fid = fopen(outfile,'a');  % open file in append mode
fprintf(fid, '\n');

n_test = 10;

for it=1:size(NK,1)
    
    iter_c = [];
    time_DDS = [];
    time_FW_1 = [];
    time_FW_2 = [];
    err_1 = [];
    err_2 = [];
    
    num_var = NK(it,1);
    deg = NK(it,2);
    scriptDir = fileparts(mfilename('fullpath'));
    filename = fullfile(scriptDir, sprintf('c_%d_%d.mat', num_var, deg));
    load(filename, 'C');

    flag_FW = 1; %  will change to zero if FW fails in one of the instances. 

    for it2=1:n_test
        x_p = C{it2};
        clearvars p opts
        p{1}.type = "symmetric";
        p{1}.deg = deg;
        p{1}.index = 1:num_var;
        opts.stop.max_time = 1000
        e = ones(num_var,1);

        fprintf('Running the FW algorithm ... \n');
        try
            opts.stop.gap_tol = 1e-2; %This is the default FW gap tolerance
            [z1,status1] = poly_proj(x_p,p,e,opts);
            opts.stop.gap_tol = 1e-4; 
            [z2,status2] = poly_proj(x_p,p,e,opts);
        catch ME
            % ---- FW fails ----
            fprintf('Error in FW algorithm (n=%d, k=%d): %s\n', num_var, deg, ME.message);
            flag_FW = 0;
        end
        
        poly = generate_ek_slp(num_var, deg);
        e_dir = ones(num_var,1);
        [x,y,info] = hyper_proj_DDS(x_p,poly,e_dir,num_var,deg);
        
        if flag_FW  == 1
            time_FW_1 = [time_FW_1 status1.time];
            err_1 = [err_1 max(abs(z1-x(1:num_var)))];
            time_FW_2 = [time_FW_2 status2.time];
            err_2 = [err_2 max(abs(z2-x(1:num_var)))];
        end
        iter_c = [iter_c info.iter];
        time_DDS = [time_DDS info.time];
        
    end

   
    if flag_FW ~= 0   % If FW fails. 
        fprintf(fid, '(%d,%d)  &   %.1e   & %.2f$\\pm$%.2f & %.2e$\\pm$%.2e  &  %.2f$\\pm$%.2f & %.2e$\\pm$%.2e  &  %.1f$\\pm$%.1f & %.2f$\\pm$%.2f   \\\\ \\hline\n', ...
        num_var, deg, nchoosek(num_var,deg),  mean(time_FW_1), std(time_FW_1), mean(err_1), std(err_1), mean(time_FW_2), ...
             std(time_FW_2), mean(err_2), std(err_2), mean(iter_c),std(iter_c), mean(time_DDS), std(time_DDS));
    else
        fprintf(fid, '(%d,%d)  &   %.1e    & \\multicolumn{2}{|c|}{Fail}   &  \\multicolumn{2}{|c|}{Fail}  &  %.1f$\\pm$%.1f & %.2f$\\pm$%.2f   \\\\ \\hline\n', ...
        num_var, deg, nchoosek(num_var,deg),   ...
               mean(iter_c),std(iter_c), mean(time_DDS), std(time_DDS));
    end
    
    
end
fclose(fid);