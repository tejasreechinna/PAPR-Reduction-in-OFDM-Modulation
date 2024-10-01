function y4=D_Frequency_Spectrum()
clear all;
clc;
close all;
fs=input('Enter total frequency range(in MHz)= ');% 50Mhz
fc=input('Enter Cutoff frequency(in MHz)= ');% 2
N=512;%input('Enter the total no of samples in the freq range(2^ ): ');
T=32;%input('Enter the sample duration of each carrier(2^ ): ');     
no_of_carriers=floor(N/T);

for n=1:T
    for k=1:no_of_carriers
        g(k,n)=exp(i*2*pi*k*n/no_of_carriers);
    end;
end;

f=(-N/2:N/2-1)/N*fs;
for k=1:no_of_carriers
    X(k,:)=abs(fft(g(k,:),N));
    X(k,:)=fftshift(X(k,:));
      plot(f,X(k,:));
    hold all;
    end;

    title('Frequency spetrum of original OFDM'),xlabel('Frequency in MHz'),ylabel('FFT');
    figure;
for k=1:no_of_carriers
for p=1:N
   pp=abs(p-N/2);
   if(pp/N*fs>fc/2)
       X(k,p)=0;
end;    
end;
    plot(f,X(k,:));
    hold all;

end;

title('Frequency spetrum of band limited OFDM'),xlabel('Frequency in MHz'),ylabel('FFT');

disp('Total of carriers= ');
disp(no_of_carriers);