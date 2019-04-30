clc
clear all
addpath(genpath('Data'))
addpath(genpath('Measures'))

% load data
Files = dir(fullfile('Data', '*.mat'));
 
Max_datanum = length(Files);   % the number of test data
 
for i = 1:  Max_datanum
     data_num = i;           % the index of test data 
     Dname = Files(data_num).name; % the name of test data
     disp(['***********The test data name is: ***' num2str(data_num) '***'  Dname '****************'])
     load(Dname);
     disp(['Test RSE'])
     tic
     result = Test_RSE(X,Y);
     temp_time = toc
     Result(i,:)= ClusteringMeasure_new(Y, result)
end