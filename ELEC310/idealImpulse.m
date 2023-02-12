%% ELEC 310 - Assignment 8
% This function returns h, the coefficients of the ideal impulse response for the given signal in noisy.wav 

function h = idealImpulse(L,sampleFreq)
fs = sampleFreq; % sample frequency
w = hamming(L); % w is the hamming window
hi = zeros(L,1); % hi is the ideal FIR filter response
i = 1; 
for n=-(L-1)/2:(L-1)/2 
if n == 0 
	hi(i) =20 / fs + 1 - 200 /fs; % evaluate 0/0 case
else 
    % hi is the ideal filter response 
    hi(i) = sin(20 / fs * pi * n) ./ (pi * n) +  sin(pi * n) ./ (pi * n) - sin(200 * pi / fs * n) ./ (pi * n); 
end
     i=i+1; % increase index 
end 
h = w.* hi; % compute and return ideal impulse response
      