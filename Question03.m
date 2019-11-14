clear;close all;clc
load('file158.mat')
opt = compareOptions('InitialCondition','z');
N = length(DataId.u);
NN = fix(0.5 * N);
DataId_train = iddata(DataId.y(1:NN),DataId.u(1:NN));
DataId_vali = iddata(DataId.y(NN+1:N),DataId.u(NN+1:N),1);
for nk = 1:1:10
    figure
    M1 = oe(DataId_train,[1,2,nk]);
    M2 = oe(DataId_train,[1,3,nk]);
    M3 = oe(DataId_train,[1,4,nk]);
    M4 = oe(DataId_train,[2,3,nk]);
    M5 = oe(DataId_train,[2,4,nk]);
    M6 = oe(DataId_train,[3,4,nk]);
    subplot(2,1,1)
    compare(DataId_train,M1,M2,M3,M4,M5,M6,opt)
    subplot(2,1,2)
    resid(DataId_vali,M1,M2,M3,M4,M5,M6,opt)
end