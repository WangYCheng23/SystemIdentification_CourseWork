%%% Demo of nonparametric identification
 clear all
 close all
 clc
 %% fifth order stable model
 %A = randn(5);
 %while max(abs(eig(A))) >= 1
 %    A = randn(5);
 %end
 %B = randn(5,1);
 %C = randn(1,5);
 %G = ss(A,B,C,0,1);
 load('ChengWang_G.mat')
 G = G/dcgain(G);
 % so far, we have a stable random system G with DC gain 1
 %so far we have just generated a random stable system.
 [num,den] = tfdata(G,'v'); 

%% Design of the input
%n = @xx;
Ni = 7;
u = prbs(Ni); % regenerate  PRBS if n=7, then the input without repetition...
... has 2^7-1=127 elementes.
Nb = 2^Ni-1;
NB = 2*Nb;
u = 2*u-1;
u = [u;u];
%u(2:2:254) = -u(2:2:254); % This trick is interesting  for moving the
%peaks of the fourier transform. This code does not use this trick. If you
%remove this comment, then the signal without repetitions has 254 elements!
figure
plot(abs(fft(u)))
Nrep = 200;
while size(u,1) < Nrep * 2 * NB
    u = [u;u]; % repeat u up to the size is 40 times the size of the PRBS
end

y = lsim(G,u); % filter also can be usedm but slim is better

sigma=0.05; % standard deviation for the noise.

nu = size(u,1);
u = u(nu-Nrep*NB+1:nu); % select the last half of the experiment. We hope...
...that the transient 
y = y(nu-Nrep*NB+1:nu); % idem
noise=sigma*randn(length(y),1); % generate a noise
yr=y+noise; % add the noise to the real signal
yf = fft(yr); % compute the Fourier transform of the output
uf = fft(u); % compute the Fourier transform of the input
Gf = yf./uf; % the identification of the input is the ratio between the...
...fourier transform of the output over the Fourier transform of the input
s=length(u)/Nb; %number of repetitions
w = [0:s*Nb-1]'/Nb/s*2*pi; % The range of frequencies is between 0...
...and 2*pi. The number of points is N=s*127, so the first frequency is 0...
...nan the last frequncy is 2*pi*(N-1)/N

%% Comparison between the real system and the identified system
[Gm,Gp] = bode(G,w);Gm = Gm(:); Gp = Gp(:); %bode plot of the real system
loglog(w,abs(Gf))
ind = [1:s:s/2*Nb]'; %we select only one freqency each s elements...
...as we have repeated the input signal s times
figure
subplot(211)
loglog(w(ind),abs(uf(ind)),'+',w(ind),Gm(ind),'mx',w(ind),abs(Gf(ind)),'co')
legend('input','plant','estimate')
subplot(212)
semilogx(w(ind),Gp(ind),'mx',w(ind),180/pi*angle(Gf(ind)),'co')
legend('plant','estimate')
%% Plot the Bode plot
figure
bode(G)
