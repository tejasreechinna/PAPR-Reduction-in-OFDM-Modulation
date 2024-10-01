clc;
clear all;
close all;
n=0;
while n~=8
disp(' ');
disp('STUDY OF OFDM SIGNAL WITH PAPR REDUCTION');
disp('To view QPSK baseband signal, PRESS 1');
disp('To view OFDM power spectrum, PRESS 2');
disp('To view BER performance of OFDM system, PRESS 3');
disp('To view BER when white noise added in OFDM , PRESS 4');
disp('To view Frequency Spectrum of OFDM baseband signal, PRESS 5');
disp('To view PAPR reduction using Clipping+Filtering Technique, PRESS 6');
disp('To view PAPR reduction using SLM Technique, PRESS 7');
disp('To compare PAPR reduction using SLM Technique and Clipping+Filtering Technique, PRESS 8');
disp('To exit, PRESS 8');

n=input('ENTER your choice =');
if n==1
    A_qpsk_modulation();
elseif n==2
       B_OFDM_modulation();
    elseif n==3
           C_BER_randomnoise();
        elseif n==4
               C_BER_whitenoise();
            elseif n==5
                   D_Frequency_Spectrum();
                elseif n==6
                    E_Clipping_filtering_method();    
                elseif n==7
                       F_SLM_method();
                    elseif n==8
                           G_papr_comparison();    
                        elseif n==9
                            disp('Execution Completed');    
                            else
                            disp('Sorry you entered an INVALID choice');
end;


end;