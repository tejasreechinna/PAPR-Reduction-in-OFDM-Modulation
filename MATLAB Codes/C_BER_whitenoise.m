function y32=C_BER_whitenoise() % BER vs SNR of OFDM 
clc;
clear all;
close all;
N=input('Enter the number of transmitted symbols(Power of 2)(preferably>32)=');
r=ceil(4*rand(1,N));
%QPSK modulation 
for p=1:N                                                     
bcos(p)=cos((2*r(1,p)-1)*pi/4);
bsin(p)=sin((2*r(1,p)-1)*pi/4);
bexp(p,1)=bcos(p) + bsin(p)*i;
end;
%adding white noise
bexpt=ifft(bexp); 
ebno=1:N;
ibexp=awgn(bexpt,10);                                     


bexpr=(fft(ibexp));
ber1 = semianalytic(bexp,bexpr,'psk/nondiff',4,16,ebno);                 %to calculate ber performance
ber2 = semianalytic(bexp,bexpr,'qam',16,16,ebno);                 %to calculate ber performance
ber3 = semianalytic(bexp,bexpr,'psk/nondiff',2,16,ebno);                 %to calculate ber performance
semilogy(ebno,ber1,'r',ebno,ber2,'b',ebno,ber3,'g'),legend('qpsk','16qam','bpsk'),grid on;
title('BER performance of OFDM over range of SNR'),xlabel('SNR'),ylabel('Bit Error Rate');
ylim([10^-15 1]);