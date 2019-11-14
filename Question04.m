clear;close all;clc;
load('file158.mat')
opt = compareOptions('InitialCondition','z');
M = zeros(120,3);
N = length(DataId.u);
NN = fix(0.5 * N);
DataId_train = iddata(DataId.y(1:NN),DataId.u(1:NN),1);
DataId_vali = iddata(DataId.y(NN+1:N),DataId.u(NN+1:N),1);
%figure
Model1 = oe(DataId_train,[2 4 5]);
Model2 = oe(DataId_train,[2 3 5]);
Model3 = oe(DataId_train,[1 4 5]);
%M4 = oe(DataId_train,[2 3 4]);
Model4 = oe(DataId_train,[3 4 3]);
Model5 = oe(DataId_train,[2 4 4]);

figure
compare(DataId_vali,Model1,'r',Model2,'y',Model3,'g',Model4,'m',Model5,'b',opt)
figure
resid(DataId_vali,Model1,'r',Model2,'y',Model3,'g',Model4,'m',Model5,'b',opt)
legend('Model1','Model2','Model3','Model4','Model5','Model6')