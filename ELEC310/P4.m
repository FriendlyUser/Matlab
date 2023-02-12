% Sampling frequency is 44100 samples/second
fs = 44100;
% Frequencies to find response for
f = 0:1:22050;
% Filter feedforward coefficients (impulse response for FIR filter)
h = [ 1 -2*cos(6*pi / 2205) 1 ];
% Filter feedback coefficients (single 1 for FIR filters)
a = 1;
% Compute response
H = freqz(h,a,f,fs);
% Plot magnitude response
figure
plot(f,20*log10(abs(H)))
xlabel('Frequency Response plotted in DB')
print('P4','-dpng','-r300')