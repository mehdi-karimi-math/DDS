%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% vamos is a function that returns a Vamos like polynomial with 2*m variables
%% in the "monomial format". 

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function z = vamos(m)
 num_mon=(2*m)*(2*m-1)*(2*m-2)*(2*m-3)/24-(2*m-3);
 num_var=2*m;
 z=sparse(num_mon,num_var+1);
 row=1;
   for k1=1:2*m
     for k2=k1+1:2*m
         for k3=k2+1:2*m
             for k4=k3+1:2*m
                 if ~(k1 == 1 & k2 == 2 & mod(k4,2) == 0 & k4-k3 == 1)  & ~( k4-k1 == 3 & mod(k4,2) == 0)
                    
                    z(row,k1)=1; z(row,k2)=1; z(row,k3)=1;
                    z(row,k4)=1; z(row,num_var+1)=1; 
                    row=row+1;
                 end
             end
         end
     end
 end



end