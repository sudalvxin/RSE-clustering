function [Y,Rs,Tobj] = MV_RSE(Ss,Fs,opts)
% solve:
% min_{R_i, Y} \sum_t || St - YR_t' ||_F
% s.t. Y'*Y= I;
% 
% paras:
% Ss    1xv cell, contain nxn spectral clustering 
% Fs    1xv cell, contain spectral embedding (F_i);

k = opts.k; % clusters

v = length(Ss);
[n, ~] = size(Ss{1});

% initilize
Rs = Fs;
p = ones(v,1);

max_iter = 100;

for iter = 1:max_iter
    
    % Update Y
    T = zeros(n,k);
    for idx = 1:v
        Rt = Rs{idx};
        St = Ss{idx};
        temp = St*Rt;
        pt = p(idx);
        T = T + pt*temp;
    end
    [Uy, ~, Vy] = svds(T,k);
    Y = Uy*Vy';
    
    obj = 0;
    % Update R and calculate the objective function
    for idx = 1:v
        St = Ss{idx};   
        Rt = St'*Y;   % without 
        Rs{idx} = Rt;
        temp = St - Y*Rt';
        % update weightes 
        p(idx) = 0.5/norm(temp,'fro');
        obj = obj + norm(temp,'fro');
    end
    Tobj(iter) = obj;
    
    % convergence checking
    if iter>1
        temp_obj = Tobj(iter -1);
    else
        temp_obj = 0;
    end
    if abs(obj - temp_obj)/temp_obj <1e-8
        break;
    end
end
plot(Tobj)