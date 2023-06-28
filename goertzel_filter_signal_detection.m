% example code
clc
clear
close all


Fs = 1e6;
N = 100;

% rectangular waves
rect_50k_wave = square(2*pi*50e3*(0:N-1)/Fs);
rect_16k_wave = square(2*pi*16e3*(0:N-1)/Fs);
rect_10k_wave = square(2*pi*10e3*(0:N-1)/Fs);
rect_200k_wave = square(2*pi*200e3*(0:N-1)/Fs);

% sine waves
sin_50k_wave = sin(2*pi*50e3*(0:N-1)/Fs);
sin_49k_wave = sin(2*pi*49e3*(0:N-1)/Fs);
sin_51k_wave = sin(2*pi*51e3*(0:N-1)/Fs);
sin_5k_wave = sin(2*pi*5e3*(0:N-1)/Fs);
sin_200k_wave = sin(2*pi*200e3*(0:N-1)/Fs);


% lo = sin(2*pi*697*(0:N-1)/Fs);
mid = sin(2*pi*941*(0:N-1)/Fs);
hi = sin(2*pi*1209*(0:N-1)/Fs);
% data = rect_wave + mid + hi;

% offset of 14-bit
offset = 2^13;

rect_waves = rect_50k_wave + rect_16k_wave + rect_10k_wave + rect_200k_wave;
sin_waves = sin_50k_wave + sin_49k_wave + sin_51k_wave + sin_5k_wave + sin_200k_wave + offset;



% plot(mid)

f = [50e3];
freq_indices = round(f/Fs*N) + 1;   
dft_data = goertzel(sin_waves,freq_indices);

stem(f,abs(dft_data))

ax = gca;
ax.XTick = f;
xlabel('Frequency (Hz)')
ylabel('DFT Magnitude')

figure

plot(sin_waves);
title('all waves');

figure

plot(sin_50k_wave+offset);
title('sin 50k wave');
