%% ELEC 310 FINAL
% This script is testing the vitability of coding in Matlab and using one
% of the exporting options (such as to latex) in order to minimize work.
% Generally speaking, if it takes a while to load, it means an error in the
% script has occured, to prevent this, run the entire script before
% publishing it, just makes sense lol.

%%  ELEC 310: Digital Signal Processing I 
% Michael McGuire --- August 2007 , Using matlab to check answers

%% Question 1: Using, finding the transfer function
syms n z
Q1H1 = (1+0.9*z^(-1))/(1-0.25*z^(-1)+0.0625*z^(-2))
Q1H2 = 1 /(1-0.4*z^(-1))
Q1H = simplifyFraction(Q1H1 * Q1H2)

% Using resdiuals

b = [80 72 0 0];
a = [80 -52 13 -2]
[R,p,C] = residuez(b,a)

% R goes on top
% p ends up being the factor on the bottom 

% Note to self, factor is a good and useful function.
%% Question 1: part b 
% Do the old switch a rooo, that is, H(z) = Y(z)X(z) and inverse and then 
% solve for y[n]

%% Question 1: part c
Q1Plot = z^2*(z+0.9)/((z^2-0.25*z+0.0625)*(z-0.4))
zplane([1; 0.9; 0; 0],[1' -0.65; 0.1625; - 0.025])

%% Question 2: part a, find the transfer function
syms n z
Q2y = 7.5-6.5*(0.6)^n
Q2x = sym(1)
Q2X = ztrans(Q2x)
Q2Y = ztrans(Q2y)

Q2H = Q2Y / Q2X
% https://www.wolframalpha.com/input/?i=combine+(((15*z)%2F(2*(z+-+1))+-+(13*z)%2F(2*(z+-+3%2F5)))*(z+-+1))%2Fz
% combined form near the bottom
% The answer 5(z+2)/(5z-3)

%% Question 2, part b, find the impulse response
% that is, set x[n] = delta[n], and X(z) = 1, so just inverse Z transform
% the impulse response
Q2H = (z)/(z-0.6)+2/(z-0.6)
Q2impulse = iztrans(Q2H)


%Real answer is 0.6^n u[n]+2(0.6)^(n-1)u[n]

%% Question 2, part c, is the function stable
zplane([1; 2],[1; -0.6])
Q2h =0.6^n+1.2*0.6^n;
S2 = symsum(0.6^n, n, 0, Inf)
S3 = 2*symsum(0.6^n, n, 0, Inf)
fprintf('System is stable, h[n] is absolutely summable and h[n]= %2.1f', S2 + S3)

%% TOO lazy to do the rest

%%  ELEC 310: Digital Signal Processing I 
% Michael McGuire --- August 2010 , Using matlab to check answers

%% Question 1, part a
syms n z
format rat
q1y =  4/3 - 1/3*(1/4)^n;
q1x = sym(1);
q1X1 = ztrans(q1x)
q1Y1 = ztrans(q1y)
q1h = iztrans(q1Y1 / q1X1)

q1hA =  0.25^n
q1H = ztrans(q1hA)
q1X = z^(-2) +z^(-3)+z^(-4)+z^(-5)+z^(-6)+z^(-7)+z^(-8)+z^(-9)+z^(-10)
iztrans(q1H*q1X)

%% Question 2, part a
q2H = (z^2-1)/(z^2-z+0.5)
factor(q2H)
q2Freq = (exp(j*3/4*pi)^2-1)/(exp(j*3/4*pi)^2-exp(j*3/4*pi)+0.5)
fprintf('Frequency response evaluated at 3*pi/4 is: Mag: %3.4f, Angle: %3.4f\n',abs(q2Freq),angle(q2Freq))

%% Question 3, part a
syms n z
q3X1 = (15*z^3+15/2*z^2-9*z)/((z+0.5)*(z+2)*(z-1))
q3PX1 = partfrac(q3X1)
A = limit(q3X1,z,0)
B = limit(q3X1*(z+0.5)/z,z,-1/2)
C = limit(q3X1*(z-1)/z,z,1)
D = limit(q3X1*(z+2)/z,z,-2)

q3x = iztrans(q3X1)

% Use residues in matlab to compute the answer
b = [15 15/2 -9 0]
a = [1 3/2 -3/2 -1]
[R,p,C] = residuez(b,a)
%% Question 3, part b
q3X2 = 1/(z^2-z+4)
b = [1];
a = [1 -1 4];
[r,p,k] = residue(b,a)
iztrans(q3PX2)

q3AX2 =1/(((z-0.5-j*sqrt(15)/2))*(z-0.5+j*sqrt(15)/2))
partfrac(q3AX2)
A = limit(q3X2,z,0)
B = limit(q3AX2*(z-0.5-j*sqrt(15)/2)/z,z,-0.5-j*sqrt(15)/2)
C = limit(q3AX2*(z-0.5+j*sqrt(15)/2)/z,z,-0.5+j*sqrt(15)/2)

% Checking my numerical answer from wolfram
% https://www.wolframalpha.com/input/?i=partial+fractions+(1%2F((z-0.5-i*0.5*sqrt(15))*(z-0.5%2Bi*0.5*sqrt(15))))

q3bAngle= angle(0.258199*j/(0.5+j*sqrt(15)/2))
q3Mag   = abs(0.258199*j/(0.5+j*sqrt(15)/2))
%%  ELEC 310: Digital Signal Processing I 
% Michael McGuire --- August 2014(Modified) , Using matlab to check answers

%% Question 1, part a
% Basic linearity Question
% y[n] = 6x[n-1] +4, constant makes the system non-linear, remove the
% constant and the system will work fine.

%% Question 1, part b
% Not worth the effort to define an equation to be solved using the
% z-transform in matlab
% $y[n] = 2x[n]+3/4y[n-1]$ for $x[n]=2^n*u[n]$
% $H(z)=\frac{Y(z)}{X(z)}=\frac{2}{1-\frac{3}{4}z^{-1}}$
% $X(z)=\frac{z}{z-2}$
% $Y(z)=\frac{2z^2}{(z-0.75)(z-2)}$
syms n z
H = 2*z/(z-0.75);
X = z/(z-2);
Y1 = H*X
partY = partfrac(Y1)
%latex(partY) --- may be useful in doing latex
iztrans(partY)

%% Question 2, part a
h = 4/3*kroneckerDelta(n,0)-(1/4)^n;
x = 4+cos(pi/6*n);
H = ztrans(h)
X = ztrans(x)
%Y = X*H
%y = iztrans(Y)
% Use Frequency Response to compute the rest, that is, $z = e^{jw}$
% some computations will be done in matlab
% compute |H(1)|
H1 = 4/3 - 1/(1-1/4);
% compute |H(exp(j*pi/6)|
H2 = 4 /3 - exp(j*pi/6)/(exp(j*pi/6)-1/4);
fprintf('The magnitude and angle of the frequency response evaluated at pi/6 is: %3.4f %3.4f\n',abs(H2),angle(H2))
% This results in the answer being $y[n]=4|H(e^{j0)|+|H(e^{j\frac{\pi}{6}}})|cos(\frac{\pi}{6}+1.1508)$
% abs(H2) =0.2175, angle(H2) = 1.1508
Answer = 4*abs(H1)+0.2175*cos(pi/6*n+1.1508)

%% Question 2, part b
% $y[n]=x[n]-\sqrt{3}x[n-1]+x[n-2]+0.25y[n-1]$
% 
syms n z w
H =(1-sqrt(3)*exp(-j*w)+exp(-j*2*w))/(1-0.25*exp(-j*w))

% Solve the roots for the numerical polynomial to find where the function
% is zero
theRoots = root(z^2-sqrt(3)*z+1,z);
theRoots_vpa = vpa(theRoots)
fprintf('r: %3.4f\n', abs(theRoots_vpa ))
fprintf('theta: %3.4f\n',angle(theRoots_vpa ))
% as expected, omega is equal to pi/6 and -pi/6, don't forget about 2*pi
% k,where k is an integer

%% Question 3, part a
syms n z
x = 12*n*(0.6)^(n-1)*cos(pi*n/3)
%x = 10*n*(0.6*exp(j*pi/3))^(n)+10*n*(0.6*exp(-j*pi/3))^n
X = ztrans(x)
X1 =(z^2-1.2*cos(pi/3)*z)/(z^2-1.2*cos(pi/3)*z+0.36)
dX1 = diff(X1)
%zplane([25/25; -60/25; 9/25; 0],[625 / 625; -750/625; 675/625; -270/625; 81/625])
%% Question 3, part b
syms n z
X = (4*z+5)/((z-0.6)*(z-1)^2)
partX = partfrac(X)
iztrans(partX)

% for zplane, put the numbers from (highest to lowest)/ descending order.
zplane([4/4; 5/4],[1; -2.6; 2.2; -0.6])
%% Question 4, Z transforms, part a
% I'll try two methods, partial fractions calling a z-transform function

syms n z
f1 = 0.25^(n-1);
F1 = ztrans(f1);
f2 = 0.5^n;
F2 = ztrans(f2);
F1*F2 
% for zplane, put the numbers from (highest to lowest)/ descending order.
zplane([4; 0;0],[1; -2.75; 1.5])

yReal = iztrans(F1*F2)

%% Question 4 part b 
syms n z
y3= 9/2-7/2*(1/3)^n;
Fy3 = ztrans(y3)
x3= (1/3)^n;
Fx3 = ztrans(x3)
Part4 = partfrac(Fy3/Fx3)
iztrans(Part4)

%% Question 4 part b, Alternative
% See
% https://www.wolframalpha.com/input/?i=simplify((9*z)%2F(2*(z+-+1))+-+(7*z)%2F(2*(z+-+1%2F3)))
% for simplification.
YSimple = 2*z^2/((z-1)*(z-1/3));
XSimple = (z-1/3)/z;
HSimple =(z+2)/(z-1); 
Hreal = iztrans(z/(z-1))+iztrans(2/(z-1))
% *Correct answer* is h[n]=u[n]+2u[n-1], answers are equivalent as
% kroneckerDelta(n, 0) returns 1 when n=0, else it returns 0

%% Question 5, Sampling, lowpass filters
% Difficult to use matlab to complete such a question, but I could use
% simulink to simulate the system and get a response, but I doubt that
% would be benefical, it would be better to simplify complete it by hand.
% Of course convolution is simple to do in matlab.

%% part a
%evaluate frequency response at w = 0.2pi
H0 = exp(j*0.2*pi)/(exp(j*0.2*pi)-0.1)
fprintf('The magnitude and angle is %3.4f, %3.4f, respectively \n',abs(H0),angle(H0))

H1 = exp(j*0.4*pi)/(exp(j*0.4*pi)-0.1)
fprintf('The magnitude and angle is %3.4f, %3.4f, respectively \n',abs(H1),angle(H1))

% Using the information obtained from the frequency response the answer 
% becomes very easy to compute $y[n]=25cos(2\pi100t)+25sin(2\pi200t)$
% $$y[n]=25(1.0858)\cos(2\pi*100*t-0.0639)+25(1.0270)sin(2\pi200t-0.0978)$$
%% part b
% Anything over $\pi$ in the cos or sin must be aliasing by subtracting or
% adding $2\pi$, so that leads to  the \sin(4/3 \pi n) --> \sin(-2/3 \pi n),
% remembering how the basic sin and cos graphs looks, we can deduce that
% $\sin(-\theta)=\cos(\theta+pi/2)$, so $sin(-2/3*pi/n)=cos(2/3\pi n+\pi/2)$

H2 = exp(j*2*pi/3)/(exp(j*2*pi/3)-0.1)
fprintf('The magnitude and angle is %3.4f, %3.4f, respectively \n',abs(H2),angle(H2))

% The final answer should be 
% $y[n]=25(0.9492)cos(2/3 \pi n -0.0823)+25(0.9492)cos(2/3 \pi n + \pi /2 -0.0823)$

%% Question 6, part a DFT of finite sequences
% For N = 5, this should be incorrect -- part a
N = 5
for k = 0:N-1
    XDFT(k+1) =exp(j*2*pi*k/N)+2*exp(j*4*pi*k/N)+2*exp(j*6*pi*k/N)+2*exp(j*8*pi*k/N);
    HDFT(k+1) = 1+exp(-j*2*pi*k/N);
    YDFT(k+1)=(1+exp(-j*2*pi*k/N))*(exp(j*2*pi*k/N)+2*exp(j*4*pi*k/N)+2*exp(j*6*pi*k/N)+2*exp(j*8*pi*k/N));
     %Y(k+1)=-exp(-j*10*pi*k/N)-2*exp(-j*8*pi*k/N)+exp(-j*4*pi*k/N)+2*exp(-j*2*pi*k/N);
end
% The coefficients in front on the exponentials on the Y[k] are used in the
% y[n] numerically.

%%  Question 6, part b, convolution sum
% Doing it manually/properly using FFT
x = [0 1 2 2 1 0];
h = [1 1 0 0 0 0]; % Zero padding, the correct answer seems to be length of x + length of h - 1.
t =0:5;
y = conv(x,h)
stem(t,y(1:6))
title('Convolution for Question 6 (y[n] = x[n] \ast h[n])')
tryX =fft(x)
tryH = fft(h)
tryY = tryX .* tryH
originaly = ifft(tryY) % this gives the correct answer

%% Question 6, part c, taking the inverse of the DFT
% as expected, the answer is neither symmetry or correct, according to the
% notes the correct answer should be length of x[n] + length of h[n]-1. In
% this case N must be 6, however, this can easily be accomplished by
% padding the sequence with zeroes.
YDFT
XDFT
HDFT
y=ifft(YDFT) 