
%   Problem 1

%   Sample the two signals
%   x1(t)=sin(2*pi*3*t)  and  x2(t)=sin(2*pi*0.3*t)
%   with sampling period T=0.2. 
%   Sketch the spectrum of the continuous signal, 
%   the spectrum of the sampled one and the reconstructed
%   signal from lowpass filtering of the sampled signal.
%   Confirm your results with Matlab.

N=input('Enter number of points: ');

ts=0.2

f=.3

tt=[0:ts:ts*(N-1)];

xxt=sin(2*pi*f*tt);

xxf=fft(xxt);

xxf1=fftshift(xxf);

xxt1=ifft(xxf);

tt1=linspace(-1/(2*ts),1/(2*ts),N);

plot(tt1,abs(xxf1))
pause

plot(tt,xxt,tt,real(xxt1))

compare=[xxt',real(xxt1)']

f=3

xxt=sin(2*pi*f*tt);

xxf=fft(xxt);

xxf1=fftshift(xxf);

xxt1=ifft(xxf);

tt1=linspace(-1/(2*ts),1/(2*ts),N);

pause
plot(tt1,abs(xxf1))
pause

plot(tt,xxt,tt,real(xxt1))

compare=[xxt',real(xxt1)']

ttt=[0:(ts/4):ts*(N-1)];

xxte=sin(2*pi*f*ttt);
xxte1=sin(2*pi*(f-1/ts)*ttt);

pause
plot(ttt(1:50),xxte(1:50),ttt(1:50),xxte1(1:50))
compare=[xxte',xxte1']



