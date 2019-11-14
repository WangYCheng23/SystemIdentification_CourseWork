clear;close all;clc
load('file158.mat')
N = length(DataId.u);
NN = fix(0.5 * N);
DataId_train = iddata(DataId.y(1:NN),DataId.u(1:NN));
M = arx(DataId_train,[4 3 5]);
opt = compareOptions('InitialCondition','z');
DataId_vali=iddata(DataId.y(NN+1:N),DataId.u(NN+1:N),1);
resid(DataId_vali,M,opt)