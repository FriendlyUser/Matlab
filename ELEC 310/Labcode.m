% Load sound file into MATLAB
% x will contain the samples
% fs will contain the sampling frequency in samples per second.
[x,fs] = audioread('noisy.wav');

h = [ 1 -2*cos(6*pi / 2205) 1 ];
b = h;
a = 1;
n    = length(a);
z(n) = 0;      % Creates zeros if input z is omitted
b = b / a(1);  
a = a / a(1);
Y    = zeros(size(x));
for m = 1:length(Y)
   Y(m) = b(1) * x(m) + z(1);
   for i = 2:n
      z(i - 1) = b(i) * x(m) + z(i) - a(i) * Y(m);
   end
end
z = z(1:n-1);
% Play sound with automatic scaling for audibility.
% Y contains the samples of sound.
% fs contains the sampling frequency in samples per second.
soundsc(Y,fs);
