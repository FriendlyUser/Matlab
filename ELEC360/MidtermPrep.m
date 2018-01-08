%% Midterm PREP Script
% Chapter 6 --- Stabability Question 1, Nise Textbook
clear all
close all
%% 
% s^5 +3s^4+5s^3 + 4s^2+s+3
polyVector = [1 3 5 4 1 3]
RouthHurwitz(polyVector)

%%
% Q2
v2 = [1 0 6 5 8 20]
RouthHurwitz(v2)

%%
syms s
(s+1)*(s+2)*(s+3)*(s+4)
%%
% syms a b c EPS;
syms a b c EPS;
ra=routh([1 a b c],EPS)

%% Question 12
% K(s+2)/s(s-1)(s+3)
syms s K EPS;
ra2 = routh([1 2 K-3 2],EPS)

%% Quesition 20
ra3 = routh([K+1 3 2+K],EPS)

%% Question 21
ra4 = routh([1 5 4+K 6*K],EPS)
% solve(4 - K/5==0)
% solve((6*K*(K - 20))/(5*(K/5 - 4))==0)

%% Question 22
syms a b c EPS;
ra5 = routh([1 K-b -a],EPS)

%% Example 7.2 from Nise
syms s
Gs = 120*(s+2)/((s+3)*(s+4))
CSlashR = simplify(Gs/(1+Gs))
polyVector = [1 127 252]
routh([1 127 252],EPS)
limit(Gs,s,0)
limit(s*Gs,s,0)

limit(s^2*Gs,s,0)

%% Example 7.3 from Nise
syms s
Gs =100*(s+2)*(s+6)/(s*(s+3)*(s+4))
CSlashR = simplify(Gs/(1+Gs))
polyVector = [1 107 812 1200]
routh(polyVector, EPS)
%R(s) = 5*1/s
limit(5/(1+Gs),s,0)
%%

%% Example 7.4 from Nise
Gs = 10*(s+20)*(s+30)/((s*(s+25)*(s+35)))
CSlashR = simplify(Gs/(1+Gs))
polyVector = [1 70 1375 600]
routh(polyVector, EPS)

%%
Gs = 10*(s+20)*(s+30)/((s^2*(s+25)*(s+35)*(s+50)))
CSlashR = simplify(Gs/(1+Gs))
polyVector = [1 110 3875 43760 500 6000]
routh(polyVector, EPS)

%% 
% 
G1(s) = 500*(s+2)*(s+5)/((s+8)*(s+10)*(s+12))
G2(s) = 500*(s+5)*(s+5)*(s+6)/(s*(s+8)*(s+10)*(s+12))
G3(s) = 500*(s+2)*(s+4)*(s+5)*(s+6)*(s+7)/(s^2*(s+8)*(s+10)*(s+12))
Func1 = (simplify(G1(s)/(1+G1(s))))
Func2 = (simplify(G2(s)/(1+G2(s))))
Func3 = (simplify(G3(s)/(1+G3(s))))

%%
%
[n1,d1] = numden(Func1)
routh(sym2poly(d1), EPS)
[n2,d2] = numden(Func2)
routh(sym2poly(d2), EPS)
[n3,d3] = numden(Func3)
routh(sym2poly(d3), EPS)

Kp = limit(G1(s),s,0)
Kv = limit(s*G2(s),s,0)
Ka = limit(s^2*G3(s),s,0)

%%
% Try
numg=1000*[1 8];
deng=poly([-7 -9]);
G=tf(numg,deng);
Kp=dcgain(G)
estep=1/(1+Kp)
T=feedback(G,1);
poles=pole(T)

%% Chapter 7 or 8 root Locus Plots
% Root Locus Plot
h = tf([2 5 1],[1 2 3]);
rlocus(h)
snapnow;
%%
% Example from textbook
syms s
x = s*(s+1)*(s+2)*(s+4)
den = sym2poly(x)
num = (s+3)
num = sym2poly(num)
h = tf([num],[den])
rlocus(h)

%%
% $$ $$
%
x = (s+2)*(s+4)*(s+6)
den = sym2poly(x)   
h = tf([1],[den])
rlocus(h)

%%
% 
syms s K EPS
x =s^4+ 7*s^3+14*s^2+(8+K)*s+3*K
polyVec = [1 7 14 8+K 3*K]
xD = routh(polyVec, EPS)
xD = simplify(xD)

%%
%
polyVec = [1 6 8]
routh(polyVec,EPS)
% stable function
rlocus(tf([1 4 20],[1 6 8]))

%%
% Question 8--4 
num= tf([1 2/3])
den = tf([1 6 0 0])

sys = tf([1 2/3], [1 6 0 0])
rlocus(sys)

%%
% Example NISE
syms s
top =(s+3)*(s+4)
polyTop = sym2poly(top)

bot = (s+2)*(s+1)
polyBot = sym2poly(bot)
num= tf([polyTop])
den = tf(polyBot)

sys = tf([1 7 12], [1 3 2])
rlocus(sys)

simplify(diff((s^2+3*s+2)/(s^2+7*s+12),s))
solve(s^2 + 10*s + 11==0,s)

%%
% Also, see
% <https://www.allaboutcircuits.com/technical-articles/an-introduction-to-control-systems-designing-a-pid-controller-using-matlabs/>
%- 14^(1/2) - 5
%ans =
%   -8.7417
%14^(1/2) - 5
%ans =
%   -1.2583

%%
% More examples for stability
numg=[1];
deng=([-7 -9]);
G=tf(numg,deng);
T=feedback(G,1);
%%
% finding K for s(s+1)(s+2)
clear all
syms s K EPS

NUMBER = s*(s+1)*(s+2) + K
NUmber = NUMBER
% s^3 + 3*s^2 + 2*s
polyVec = [1 3 2 K]
routh(polyVec, EPS)
%%
% checking for stability
syms s K EPS

polyVec = [1 2 0.75+K 3.15*K]
routh(polyVec,EPS)

%%
% Another question
% G(s) =K / (s)*(s+2)*(s+4)

sys = tf([1], [1 6 8 0])
rlocus(sys)
%%
% 1 / s^3+5*s^2+20*s+6
polyVec = [1 5 20 6]
routh(polyVec,EPS)
p = s^3+5*s^2+20*s+6
% Roots can only be solved numerically in this case, not exactly, therefore
% the symbolic expression to evaluate roots will not work, must have a
% vector polynomial
vectorPoly = sym2poly(p)
roots(vectorPoly)

%%
% Go = 1/ (s+1)^3
(s+1)^3
a = s^3 + 3*s^2 + 3*s + 1
polyVec = [1 3 3 1]

%%

sys = tf([1 1], [1 5 6 0])
rlocus(sys)

%%
% 
syms K s EPS
polyVec = [1 14 43 30+K]
routh(polyVec,EPS)
%% K < 572, K > -30

%%
% Using ZieglerNicholasPID Matlab GUI
s*(s+3)*(s+6)   
% https://www.wolframalpha.com/input/?i=286%2F7+-+K%2F14+%3E+0
polyVec = [1 9 18 K]
routh(polyVec,EPS)
%%
% Checking the results in matlab
Gs = tf([1],[1 9 18 0])
Gc = tf([89.608685 1],[1.2292 0])
G = Gs*Gc
COverR = feedback(G,1)
step(COverR)
stepinfo(COverR/s)

%%
% Another example
