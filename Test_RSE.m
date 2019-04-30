function y = Test_RSE(X,label)
% Input£ºX£ºdata matrices
%      label: groundtruth

v = length(X);   % the number of views
k = max(label);  % the number of clusters
Fs = cell(v, 1); 
Ss = cell(v, 1); 
n = length(label); % the number of instances


for i = 1 :v
    for  j = 1:n
         X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) );
    end
end

% construct graph
for idx = 1:v
   A0 = constructW_PKN(X{idx}',10);
   A0 = A0-diag(diag(A0));
   A10 = (A0+A0')/2;
   D10 = diag(1./sqrt(sum(A10, 2)));
   St = D10*A10*D10;
   [Ft,~,~] = svds(St,k);
   Ss{idx} = St;
   Fs{idx} = Ft;
end
% test
opts.k = k;
[Y, Rs, obj] = MV_RSE(Ss,Fs,opts); 
Y = normr(Y);
y = kmeans(Y, k, 'emptyaction', 'singleton', 'replicates', 10, 'display', 'off'); 