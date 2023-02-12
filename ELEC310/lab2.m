n=0:1:1023;
x=0.95.^n.*heaviside(n).*cos(0.3*pi*n);
xf = fft(x); % perform FFT of signal x[n]
xf = fftshift(xf); % shift zero-frequency component to center of spectrum
f = linspace(-pi,pi,1024);
plot(f,abs(xf))
print('710c','-dpng','-r600')