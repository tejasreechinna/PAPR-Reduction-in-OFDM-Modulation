 function y5=E_papr_clipConv()
clc;
clear all;
close all;
 L=input('Enter the L factor(1 to 1.5)= ');
 N=input('Enter the number of transmitted symbols(Power of 2)(preferably>32)=');
M=input('Enter the alphabet size(Power of 2 and less than number of Symbols)(preferably<32)=');
%Generating the rendom data for transmission
r=floor(M*rand(N,1));  
%Generating the rendom data for transmission
a=qammod(r,M);                                 

%Insering zeros
LN=floor(L*N);
at=a';
aa=[at(1:N) zeros(1,LN-N)]';

%Generating OFDM signal and calculating PAPR
x=ifft(aa);  
plot(x);
title("OFDM modulated signal");
figure;
x_mag=abs(x);
subplot(3,1,1),stem(x_mag),title('Normal OFDM signal');
xlim([0 LN]);

x_max=0.7*max(x_mag);
for j=1:LN         %Clipping the signals above threshold(here 70% of original value)
if(x_mag(j,1)>x_max)
    x_mag1(j,1)=x_max;
else
    x_mag1(j,1)=x_mag(j,1);
end;    
end;

subplot(3,1,2),stem(x_mag1),title('Clipped OFDM signal');
xlim([0 LN]);

%Filtering the clipped signal 
h=[ones(1,N) zeros(1,LN-N)]';
x_mag1=conv(x_mag1,h);
subplot(3,1,3),stem(x_mag1),title('Clipped and Filtered OFDM signal');
xlim([0 2*LN]);

%Calculating PAPR of Clipped and Filtered signal

papr=max(x_mag.^2)/mean(x_mag.^2);
disp('PAPR of original OFDM');
disp(papr);
papr1=max(x_mag1.^2)/mean(x_mag1.^2);
disp('PAPR of clipped OFDM');
disp(papr1);