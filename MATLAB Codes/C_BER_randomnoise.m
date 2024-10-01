function y31=C_BER_randomnoise()
clc;
clear all;
close all;
N=input('Enter the number of transmitted symbols(Power of 2)=');
r=ceil(4*rand(1,N)); % created random data

%generating QPSK modulated signal 
for p=1:N           
bcos(p)=cos((2*r(1,p)-1)*pi/4);
bsin(p)=sin((2*r(1,p)-1)*pi/4);
bexp(p,1)=bcos(p) + bsin(p)*i;
end;

bexpt=ifft(bexp); % OFDM modulation

%adding noise for the modulated signal 
ebno=1:N; % energy per bit/noise spectral density 
for p=1:N
  bexpr(p,1)=bexpt(p,1) + randn;                                    
end;

%OFDM demodulation 
bexpr=(fft(bexpr));

% calculating BER
ber_qpsk= semianalytic(bexp,bexpr,'psk/nondiff',4,16,ebno);                 
ber_qam = semianalytic(bexp,bexpr,'qam',16,16,ebno);               
ber_bpsk = semianalytic(bexp,bexpr,'psk/nondiff',2,16,ebno);  

semilogy(ebno,ber_qpsk,'r',ebno,ber_qam,'b',ebno,ber_bpsk,'g');
legend('qpsk','16qam','bpsk'),grid on;
title('BER performance of OFDM over range of SNR'),xlabel('SNR'),ylabel('Bit Error Rate');
ylim([10^-15 1]);