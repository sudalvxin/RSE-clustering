% �������ֶ���ָ��������ྫ��
[ARI,NMI,ACC] = Clustering_measure(label,gt);
% ���룺label: your labels
% gt: the real labels

% ������������������ָ��
addpath 'Measures'
ARI = RandIndex(label,gt);
NMI = MutualInfo(label,gt);
ACC =  Accuracy(label,gt);