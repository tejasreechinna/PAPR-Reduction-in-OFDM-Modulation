function y1 = A_qpsk_modulation()
    data = input('Enter the data values'); % use brackets to mention sequence 
    N = length(data); % make sure to use more than 6 [ -1 , 2 , -1 , 0 , -4 , 2, 3 , 0 , 4 , -5]
    fprintf('length of data = ');
    disp(N);

    % Separating even and odd indexed data
    odd = data(1:2:N);
    even = data(2:2:N);

    subplot(2,1,1), stem(odd), title('Odd sequence data'), ylabel("amplitude"), xlabel("Time");
    subplot(2,1,2), stem(even), title('Even sequence data'), ylabel("amplitude"), xlabel("Time");
    figure;

    % Condition for handling odd number of data inputs
    if mod(N, 2) ~= 0
        odd((N+1)/2) = data(N); % that xtra value is now an odd data 
        even((N+1)/2) = 0; %one zero is padded into even sequence to make all length equal
    end;

    fprintf('odd = '), disp(odd);
    fprintf('even = '), disp(even);

    % Converting unipolar to bipolar
    for i = 1:N         
        if data(i) == 0
            data(i) = -1;
        end;
    end;
    fprintf('bipolar data = '), disp(data);

    % Balanced modulator   
    T = 0.5;
    t = 0:0.001:T;
    cos_carrier = cos(8 * pi * t / T);
    sin_carrier = sin(8 * pi * t / T);

    % Adjust carrier lengths to match the length of odd and even sequences
    cos_carrier = repmat(cos_carrier, 1, length(odd));
    sin_carrier = repmat(sin_carrier, 1, length(even));

    % Reshape odd and even sequences to match the length of the carrier
    odd = reshape(repmat(odd, length(t), 1), 1, []);
    even = reshape(repmat(even, length(t), 1), 1, []);

    modOut1 = cos_carrier .* odd;
    modOut2 = sin_carrier .* even;

    modulated_output = modOut1 + i*modOut2;

    subplot(3,1,1), plot(modOut1), title('In phase modulated sequence'), xlabel('Time (in msec.)'), xlim([0 length(modOut1)]);
    subplot(3,1,2), plot(modOut2), title('Quadrature modulated sequence'), xlabel('Time (in msec.)'), xlim([0 length(modOut2)]);
    subplot(3,1,3), plot(modulated_output), title('QPSK modulated signal'), xlabel('Time (in msec.)'), xlim([0 length(modulated_output)]);
end
