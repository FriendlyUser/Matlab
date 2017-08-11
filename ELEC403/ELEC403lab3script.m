%% ELEC 403 Lab 3 Script - EXPERIMENT 3
% DESIGN OF A BAND-LIMITED DIFFRERENTIATOR FOR VELOCITY ESTIMATION BASED ON
% NOISY POSITION DATA %
% This script is used to fulfill the requirements in the lab manual.  %
%% 3.6.1 - following Sec. 3.3 to generate noise-free position signal s[n] and v[n]
close all
clear all

t = 0:1/512:(2-1/512);
t = t(:);
randn('state', 7)
a = 0.25*randn(7,1);
randn('state', 19)
b = 0.25*randn(7,1);
s = 0.3*ones(1024,1);
v = zeros(1024,1);
for i = 1:7,
 s1 = a(i)*sin(2*pi*i*t);
 s2 = b(i)*cos(2*pi*(i-0.5)*t);
 s = s + s1 + s2;
 v1 = i*a(i)*cos(2*pi*i*t);
 v2 = (i-0.5)*b(i)*sin(2*pi*(i-0.5)*t);
 v = v + 2*pi*(v1 - v2);
end 
figure
plot (t,s)
xlabel('Time in seconds')
title('Position signal s[n]')
print('Reproduced3_1a','-dpng','-r300')
figure
plot (t,v)
xlabel('Time in seconds')
title('Velocity signal v[n]')
print('Reproduced3_1b','-dpng','-r300')
%% 3.6.2 - get a conventional differentiator of length 23 by following Sec. 3.3

fs = 512;
Ts = 1/fs;
N = 23;
M = (N-1)/2;
n = 1:1:M;
h = cos(n*pi)./(Ts*n); % compute desired impulse response using (3.5)
h = [-fliplr(h) 0 h]; % compute desired impulse response using (3.4)
win = hamming(N); % construct 41-point Hamming window
h_diff = win(:).*h(:); % generate the impulse response of the differentiator

% We now apply the differentiator to the position signal s[n] by discrete convolution:
sw = conv(h_diff, s); % perform digital differentiation by discrete convolution
s_diff = sw(12:1035); % reduce the output length to 1024

figure
plot (t, s_diff)
title('Output of differentiator s-diff[n]')
xlabel('Time in seconds')
axis([0 2 -30 30])
print('Reproduced3_2a','-dpng','-r300')

figure
plot(t,v)
title('Exact velocity signal v[n]')
xlabel('Time in seconds')
print('Reproduced3_2b','-dpng','-r300')

%% 3.6.3 - generate noise w[n] and noise-corrupted position signal x[n]
randn('state',9); % sets a seed state for generating a random sequence
w0 = randn(1024,1); % generate 1024 Gaussian white random samples
mw = mean(w0); % evaluate its mean value
w0 = w0 - mw; % modify w0 to have a zero-mean
c = 0.3/sqrt((w0'*w0)/1024);
w0 = c*w0; % modify w0 to have a standard deviation = 0.3
h = fir1(250,0.7,'high'); % get a good highpass FIR filter with cutoff freq. = 0.7
w1 = conv(h,w0); % apply highpass filtering to the white sequence
w = w1(126:1149); % cut the filtered sequence to a right size
w = w(:); % make sure w[n] is a column vector
x = s + w; % Generate noisy position signal

figure
plot(t,x)
title('Noise-corrupted position signal x[n]')
xlabel('Time in seconds')
print('Reproduced3_3a','-dpng','-r300')

figure
sww = conv(h_diff, x); % perform digital differentiation by discrete convolution
w_diff = sww(12:1035); % reduce the output length to 1024
plot(t,w_diff)
title('Response to differentator to noisy x[n]')
xlabel('Time in seconds')
print('Reproduced3_3b','-dpng','-r300')
%% 3.6.4 - design BLD with N =23, wp = 0.2pi, wa=0.5pi and Ts = 1/512
format long
h_BLD = lab3_363(23,1/512,0.2*pi,0.5*pi);
h_BLD
%% 3.6.5 - apply BLD designed in 3.6.4 to x[n] save figures.
xx = conv(h_BLD, x); % perform digital differentiation by discrete convolution
x_diff = xx(12:1035); % reduce the output length to 1024
figure
plot(t,x_diff);
axis([0 2 -30 30])
title('Applied BLD to noisy x[n]')
xlabel('Time in seconds')
print('Pic3_5','-dpng','-r300')

figure
sssx = conv(h_BLD, s);
sss_diff = sssx(12:1035);
plot(t,sss_diff);
axis([0 2 -30 30])
xlabel('Time in seconds')
title('Applied BLD to s[n]')
print('Pic3_5b','-dpng','-r300');
