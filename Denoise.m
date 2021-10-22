function [EEG_averaged,EEG_bandpassed] = BME772ProjectDenoise(EEG_noisy, M, time, fs, x)

% This function is used to denoise the signal by bandpassing it and sync
% averaging it
% Sync Averaging the signal

%Define a matrix of zeroes
y_bar=0;
%Create for loop to add all signals into the matrix (inetgral of all signal relizations)
for sig = 1:M
    y_bar = y_bar + EEG_noisy(sig,:);
end
%Divide by M to average by M copies
EEG_averaged = y_bar/M;

if x=='Y'
%Plotting Averaged Signal
figure;
hold on
subplot(2,1,1);
plot(time,EEG_averaged);
title('Syncronized Averaged EEG Signal');
ylabel('Amplitude');
xlabel('Time (sec)');
legend('EEG Signal');
grid on;
else if x=='N'
        disp([' ']);   
else 
    disp(['Error in Plotting Average Signal']);
    end
end
        
% Bandpassing the signal

% Corner frequencies: 0.5 Hz to 30 Hz
% Butterworth Filter: 6th degree (need a sharp cutoff)

%Defining the conrner frequencies
fc_low = 0.5/(fs/2);
fc_high = 30/(fs/2);
%Design Filter
[b,a] = butter(6, [fc_low fc_high]);
% Filtering
EEG_bandpassed = filter(b,a,EEG_averaged);

if x=='Y'
%Plotting bandpassed signal
subplot(2,1,2);
plot(time,EEG_bandpassed);
title('Bandpass Filtered Signal');
ylabel('Amplitude');
xlabel('Time (sec)');
legend('EEG Signal');
hold off
grid on;
else if x=='N'
        disp([' ']);   
else 
    disp(['Error in Plotting Bandpassed Signal']);
    end
end

disp(['Denoising is complete!']);

