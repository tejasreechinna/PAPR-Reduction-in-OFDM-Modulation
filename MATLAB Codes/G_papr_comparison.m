function y7=G_papr_Comparison()
clc;
clear all;
close all;
N=input('Enter the number of transmitted symbols(Power of 2)(preferably>32)=');
M=input('Enter the alphabet size(Power of 2 and less than number of Symbols)(preferably<32)=');
L=input('Enter the L factor(1 to 1.5)= ');
paprdb1s=1;
paprdb1=100;
paprdb=0;

while paprdb1>paprdb-4
                                   % Normal OFDM
%16 point QAM modulation
r=floor(M*rand(N,1));
bexp=qammod(r,M);

% Calculating |IFFT| square and displaying |IFFT|
ibexp=ifft(bexp);
mibexp=abs(ibexp);
smibexp=mibexp.^2;
% subplot(2,1,1),stem(mibexp);
% xlim([0 N]); 

%Calculating PAPR
papr=(max(smibexp))/(mean(smibexp));
paprdb=10*log(papr);
                                  % OFDM modified by Selective Mapping
                                  % Technique

% Normalized Riemann Matrix                                   
rm=gallery('riemann',N);
b=rm/N;

% Elementwise Multiplication
for i=1:N
    for j=1:N
    bexp1(i,j)=b(i,j).*bexp(j,1);
    end;
end;

% Calculating |IFFT| square
ibexp1=ifft(bexp1);
mibexp1=abs(ibexp1);
smibexp1=mibexp1.^2;

% Calculating PAPR for each of the N blocks
for i=1:N
papr1(i,1)=(max(smibexp1(i,:)))/(mean(smibexp1(i,:)));
end;

% Finding the block with minimum PAPR
xm=1;
for i=2:N
if (papr1(i,1)<papr1(xm,1))
    xm=i;
end;
end;

% Displaying |IFFT| for the block with minimum PAPR
% subplot(2,1,2),stem(mibexp1(x,:));
% xlim([0 N]); 

% Minimum PAPR in dB
paprdb1=10*log(papr1(xm,1));

a=bexp;
LN=floor(L*N);
at=a';
aa=[at(1:N) zeros(1,LN-N)]';
% disp('After inserting zeros');
% disp(aa);

x=ifft(aa);                                  %Generating OFDM signal and calculating PAPR
x_mag=abs(x);
% figure,subplot(3,1,1),stem(x_mag);
% xlim([0 LN]); 
paprs=max(x_mag.^2)/mean(x_mag.^2);
paprdbs=10*log(paprs);
x_max=0.7*max(x_mag);

for j=1:LN                                   %Clipping the signals above threshold(here 0.2)
if(x_mag(j,1)>x_max)
    x_mag1(j,1)=x_max;
else
    x_mag1(j,1)=x_mag(j,1);
end;    
end;

subplot(3,1,2),stem(x_mag1);
xlim([0 LN]); 
                                           %Filtering the clipped signal 
h=[ones(1,N) zeros(1,LN-N)]';
x_mag2=conv(x_mag1,h);
subplot(3,1,3),stem(x_mag2);
xlim([0 2*LN]); 

                                           %Calculating PAPR of Clipped and Filtered signal
papr1s=max(x_mag2.^2)/mean(x_mag2.^2);
paprdb1s=10*log(papr1s);

end;

disp('PAPR of normal OFDM=');
disp(paprdb);
disp('PAPR of SLM modified OFDM=');
disp(paprdb1);
disp('PAPR of clipped OFDM=');
disp(paprdb1s);

subplot(2,1,1),stem(mibexp),title('Normal OFDM signal');
xlim([0 N]); 
subplot(2,1,2),stem(mibexp1(xm,:)),title('SLM modified OFDM signal');
xlim([0 N]); 
figure,subplot(3,1,1),stem(x_mag),title('Normal OFDM signal with zero padding');
xlim([0 LN]); 
subplot(3,1,2),stem(x_mag1),title('Clipped OFDM signal');
xlim([0 LN]); 
subplot(3,1,3),stem(x_mag2),title('Clipped and Filtered OFDM signal');
xlim([0 2*LN]); 
eff1=(1-paprdb1/paprdb)*100;
eff2=(1-paprdb1s/paprdb)*100;
disp('Efficiency of SLM technique in %age=');
disp(eff1);
disp('Efficiency of Clipping+Filtering technique in %age=');
disp(eff2);
if(eff1>eff2)
    disp('Hence SLM technique prvides more reduction in PAPR');
else
    
    disp('Hence Clipping+Filtering technique provides more reduction in PAPR');
end;