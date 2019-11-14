%% INITIAL
clear;close all;clc; 
load('file158.mat')
%% INPUT MODIFIED
%u = [u;u];
%% REAL SYSTEM
y = DataId.y;
u = DataId.u;
yf = fft(y);
uf = fft(u);
Gf = yf./uf;
%plot(abs(fft(u)))
%figure
%% IDENTIFICATION SYSTEM
N = length(DataId.u);
NN = fix(0.5 * N);
DataId_train = iddata(DataId.y(1:NN),DataId.u(1:NN));
Gi = arx(DataId_train,[4 3 5]);
%% COMPARASION
l = length(u);
s=l/127;%fix(l/100); %number of repetitions
N = length(u);
w=[0:s*127-1]'/127/s*2*pi;
%w = w';
[Gm,Gp] = bode(Gi,w);Gm = Gm(:); Gp = Gp(:); %bode plot of the real system
loglog(w,abs(Gf))
ind=[30:s:s/2*127]'; %we select only one freqency each s elements...
...as we have repeated the input signal s times
subplot(211)
loglog(w(ind),abs(uf(ind)),'+',w(ind),Gm(ind),'mx',w(ind),abs(Gf(ind)),'co')
legend('input','arx','freq')
subplot(212)
semilogx(w(ind),Gp(ind),'mx',w(ind),180/pi*angle(Gf(ind)),'co')
legend('arx','freq')
