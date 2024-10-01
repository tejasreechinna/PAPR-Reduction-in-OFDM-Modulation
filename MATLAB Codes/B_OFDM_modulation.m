 function y2=B_OFDM_modulation()
clc;
clear all;
close all;
N=input('Enter the number of transmitted symbols(Power of 2 > 32)=');
%Generation of random data to be transmitted
r=ceil(4*rand(1,N));       
plot(r),title('random data'),xlabel('time'),ylabel('Amplitude');
figure; %figure1Q12 

%loop for qpsk baseband genaration
for p = 1:N                  
    bcos(p) = cos((2 * r(1, p) - 1) * pi / 4);
    bsin(p) = sin((2 * r(1, p) - 1) * pi / 4);
    bexp(1, p) = bcos(p) + bsin(p) * i;                                            
end;

% Plotting the QPSK waveform components
subplot(3, 1, 1), plot(bcos), title("Cosine part of QPSK signal"), xlabel('Symbol index'), ylabel('Amplitude');
subplot(3, 1, 2), plot(bsin), title("Sine part of QPSK signal"), xlabel('Symbol index'), ylabel('Amplitude');
subplot(3, 1, 3), plot(real(bexp)), title("Real part of QPSK signal (cos component)"), xlabel('Symbol index'), ylabel('Amplitude');

nz=input('Enter the number of zeros to be padded in middle= ');
%zero padding for gaurd between samples 
bexp1=[bexp(1:N/2) zeros(1,nz) bexp(N/2+1:N)]; 

%plot(bexp1);

ibexp=ifft(bexp1);  % ofdm modulation                                                                  
z=fft(ibexp);       % ofdm demodulation
q=fftshift(z);
mag=abs(q);         % magnitude spectrum 
psd=mag.^2;         % PSD which is sqr of magnitude spectrum                                                                           %for power
figure,plot(psd),title('OFDM spectral'),xlabel('Fft samples'),ylabel('power'); %linear plot
figure,plot(10*log(psd)),title('OFDM'),xlabel('Fft samples'),ylabel('power in db'); %dB plot