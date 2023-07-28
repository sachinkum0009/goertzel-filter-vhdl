% final test

clc;
clear;
close all;

% Define the parameters
frequency = 50e3; 
amplitude = 1;  % Amplitude of the sine wave
N = 100;   % Number of Samples
samplingRate = 1e6; % Sampling rate of 1 MHz

t = 0:1/samplingRate:(N-1)/samplingRate;
off_set=(2^13);
%signal = (sin(2*pi*frequency*t)+1);
%signal = [(square(2*pi*frequency*t)+1)*(2^13-1) (square(2*pi*16e3*t)+1)*(2^13-1) (square(2*pi*10e3*t)+1)*(2^13-1) (square(2*pi*200e3*t)+1)*(2^13-1)];

% frequencies = [50e3 16e3 10e3 200e3];
frequencies = [50e3 49e3 51e3 5e3 200e3];
signal_to_save = [];
break_signal = [1 1 1 1 1 1 1 1 1 1];
for i=1:4
    signal = (sin(2*pi*frequencies(i)*t)+1)*(2^13-1);
    % signal_to_save = [signal_to_save signal];
    targetFrequency = 50e3;
    magnitude = my_new_goerztel_filter(signal, targetFrequency, samplingRate);

    disp(['Magnitude at ', num2str(targetFrequency), ' Hz: ', num2str(magnitude)]);
    figure;
    stem(targetFrequency, magnitude, 'filled');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title(sprintf("%d",frequencies(i)));
    grid on;
    % Save the signal to a text file
    
    % signal_to_save = [signal_to_save break_signal];
    
    figure;
    plot(signal);
    title(sprintf("%d",frequencies(i)));
    xlabel('Time');
    ylabel('Magnitude');

end
% filename = 'signals_rect_ones.txt';
% fid = fopen(filename, 'w');
% fprintf(fid, '%04x\n', int32(round(signal_to_save)));
% 
% fclose(fid);
