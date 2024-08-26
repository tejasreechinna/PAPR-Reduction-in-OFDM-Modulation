function y6=F_papr_SLM()
clc;
clear all;
close all;
N=input('Enter the number of transmitted symbols(Power of 2 >32)=');
M=input('Enter the alphabet size(Power of 2 < N)(preferably<32)=');
paprdb1=1;
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
subplot(2,1,1),stem(mibexp),title('Normal OFDM signal');
xlim([0 N]); 

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
x=1;
for i=2:N
if (papr1(i,1)<papr1(x,1))
    x=i;
end;
end;

% Displaying |IFFT| for the block with minimum PAPR
subplot(2,1,2),stem(mibexp1(x,:)),title('SLM modified OFDM signal');
xlim([0 N]); 

% Minimum PAPR in dB
paprdb1=10*log(papr1(x,1));
end;

disp('PAPR of normal OFDM=');
disp(paprdb);

disp('PAPR of SLM modified OFDM=');
disp(paprdb1);