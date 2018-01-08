%% ELEC 360 Final Exam Prep
% Will focus on the latter half of the course and the Nise textbook
% examples I haven't gone through yet. Note that the control system plots
% can give phase margin and gain margin by right-clicking with options.
%%
% * About 25% weightage for topics before midterm
% * About 75% weightage for topics after midterm
% * Controller Design ?E10 mark question ?Eany approach can be used
% * Root locus, Bode Plot, Nyquist plot, State Space Modelling are of major focus area
%%
% <html><table><tr><th>Chapter</th><th>Section #</th></tr><tr><td>Chapter 1</td><td>All sections</td></tr><tr><td>Chapter 2</td><td>Sections 2-1, 2-2, 2-3, 2-4, 2-5, and 2-6</td></tr><tr><td>Chapter 3</td><td>Section 3-1 &amp; section 3-3</td></tr><tr><td>Chapter 5</td><td>All sections</td></tr><tr><td>Chapter 6</td><td>Sections 6-1, 6-2, 6-3, 6-5, 6-6, 6-7</td></tr><tr><td>Chapter 7</td><td>Sections 7-1, 7-2, 7-3, 7-4, 7-5, 7-6, 7-7, 7-10, 7-11, 7-12</td></tr><tr><td>Chapter 8</td><td>Sections 8-1, 8-2, 8-3</td></tr><tr><td>Lab Experiments</td><td>1 to 3</td></tr></table>
% </html>
%%
% <html>
% <details><summary>Course Objectives</summary>
% Introduction in the theory and practice of control engineering. <br>
% Understanding the mathematical tools used in control system analysis and
% design.  <br>
% Design closed-loop control system and evaluating their performance.  <br>
% Introduction to MATLAB as a tool for control design.  <br>
% </details> </html>
%%
% <html>
% <details><summary>Learning Outcomes</summary>
% Understand terminologies used in control systems <br>
% Derive transfer functions of elementary electrical systems <br>
% Analyze transient and steady state system response of linear time
% invariant systems <br>
% Assess closed loop system performance using root-locus analysis <br>
% Assess closed loop system performance using frequency response analysis <br>
% Evaluate closed loop stability using Nyquist method <br>
% Design of PID controllers and lead/lag compensators <br>
% Utilize MATLAB to validate calculations <br>
% </details> </html>
%% Numbered List of sections to study
% 
% # Bode Plot, Frequency Domain Plots, Root Locus
% # Designing a control system with resistances and capactiance values
% # Compute Phase And Gain Margin
%% Notes
%  [Gm,Pm,Wcg,Wcp] = margin(SYS) computes the gain margin Gm, the phase 
%  margin Pm, and the associated frequencies Wcg and Wcp, for the SISO 
% open-loop model SYS (continuous or discrete). 
clear all
close all
addpath('MatlabFiles/')  
%% Examples from Schaum's Outline of Feedback and Control Systems
%
% $\frac{1}{s+1}$
G = tf([1],[1,1])
% Using data cursor is quite helpful
nyquist(G)
%%
% $\frac{1}{s^3(s+1)}$
G2 = tf([1],[1,1,0,0,0])
nyquist(G2)
%% Bode Plots
% $$\frac{100(1+j\omega/10)}{1+j\omega}$$
G3 = tf([1],[1,1])
bode(G3)
G4 = tf([10,100],[1,1])
bode(G4)
BodePlotGui(G4)
figure
% Another plot
G5 = tf([100,0],[1/10,1])
bode(G5)
%% Examples from Nise
% 
G6 = tf([1],[1,6,8])
bode(G6)
BodePlotGui(G6)
figure
%
nyquist(G6)
%%
%
G7 = tf([1,3],[1 3 2 0])
bode(G7)
BodePlotGui(G7)
%% 
% Example 10.3 Nise
syms s 
P5 = (s+2)*(s^2+2*s+25)
poly = sym2poly(P5)
G8 = tf([1 3],poly)
bode(G8)
%% 
% example 10.5 Nise
clear all
close all
G1 = tf([1,2],[1,0,0])
nyquist(G1)

%%
% example 10.5 solved using Nise textbook, with range of omega
numg=[1 2]; % Define numerator of G(s).
deng=[1 0 0]; % Define denominator of G(s).
G111=tf (numg, deng) % Create and display G(s).
nyquist(G111) % Make a Nyquist diagram.
w=0:0.5:10; % Let 0 <w< 10 in steps of 0.5.
[re,im]=nyquist(G111,w); % Get Nyquist diagram points for a
% range of w.
points=[re(:,:)', im(:,:)',w']
%%
% TryIt 10.2
G=zpk([-3, -5],...
    [2,4],1);
nyquist(G)

% Skill-Assessment Exercise 10.3
G1=zpk([],...
    [-2,-4],1)
nyquist(G1)
%%
% More Nyquist examples
% Example 10.6
G2 = zpk([],...
    [0,-3,-5],1)
P = nyquistoptions;
P.ShowFullContour = 'on';
P.Xlim = [-0.1,0.1];
P.Ylim = [-1,1];
h = nyquistplot(G2,[],P);
%axis([-0.2 5],[-2,2])
% Example 10.7
G3 = zpk([], ...
    [-1+j,-1-j,-2],1)
nyquist(G3)

%%
% Self-assignment Excerise 10.4
G4 = zpk([],...
    [-2,-4,-6],1)
nyquist(G4)
ltiview(G4)
% see https://www.wolframalpha.com/input/?i=(iw-2)*(iw-4)*(iw-6)%3D0
% Skill-Assessment Excerise 10.5, computing phase margin and gain margin 
%margin(G4) 
%%
% # Right-click in the graph area.
% # Select Characteristics.
% # Select All Stability Margins.
% # Let the mouse rest on the margin points to read the gain and phase margins.
%%
% answer is $$ K < 480, \quad w = \sqrt(44) $$
%%
%
GNyquist = zpk([],[0,-3,-6],50)
Gny = feedback(GNyquist,1)
nyquist(Gny)

GNy2 = zpk([],[0,0,-1],50)
GNyh = zpk([-4],[],1)
%GPlot = feedback(GNy2,GNyh)
GPlot3 = GNy2*GNyh
nyquist(GNy2*GNyh)
%%
% Example 10.8
numg=6; % Define numerator of G(s).
deng=conv ([1 2],[1 2 2]); % Define denominator of G (s).
G=tf (numg, deng) % Create and display G (s).
nyquist(G) % Make a Nyquist diagram.
grid on % Turn on grid for the Nyquist
% diagram.
title ('Open-Loop Frequency Response')
% Add a title to the Nyquist
% diagram.
[Gm,Pm,Wcg,Wcp]=margin(G); % Find margins and margin % frequencies. 'Gm(dB); Pm(deg.); 180 deg. freq.(r/s); 0 dB freq. (r/s)?E
% Display label.
margins=[20*log10(Gm),Pm,Wcg,Wcp]
% Display margin data.

% Find the phase margin and gain margin using bode plot
bode(G)
margin(G)
%%
% Example 10.9 with K = 200
numg=200; % Define numerator of G(s).
deng=conv ([1 2],[1 2 2]); % Define denominator of G (s).
G6=tf (numg, deng) % Create and display G (s).
bode(G6)
margin(G6)
%%
% Skill-Assessment Exercise 10.6
G7 = zpk([],[-5,-20,-50],1)
bode(G7)
margin(G7);
[Gm,Pm,Wcg,Wcp]=margin(G7)
[num,den] = tfdata(G7)
% Doing it manually
BodePlotGui(tf([num],[den]))
figure
%%
% $$G_m=20log_{10}K$$
%%
% Using the gain margin, which is the difference between the 0 line and the
% magnitude value when the phase margin is $-180^o$. K is computed to be K
% < 96 270 in Nise
%% Nicholos Chart
% One example, honestly doesn't seem that important to the final
G=zpk([],...
[-5,-20,-50],8000)
nichols(G)
grid on

%% Root Locus
%
G10=zpk([],[0,-7],1);
G101 = feedback(G10,1)
[num,den] = tfdata(G101)
k=-500:1:500;
rlocus(tf(num,den),k)
sgrid
%%
% http://higheredbcs.wiley.com/legacy/college/nise/0471794759/justask/Q118.html#detailed
% Example 9.3
G10=zpk([],[0,-4,-6],1);
k=-250:0.1:250;
rlocus(G10,k)
sgrid
%%
% Example 9.4
G101 = zpk([],[0,-7],1)
k=-250:0.1:250;
rlocus(G101,k)
sgrid
%%
G1011 = zpk([-10],[-25.52,0,-7],1)
rlocus(G1011)


%% Design Questions
%
G = zpk([],[0,-1,-3],1)
k=-2500:0.1:2500;
rlocus(G,k)
Zeta= 0.707
wn = 1.977819676
sgrid(Zeta,wn)
% controlSystemDesigner('rlocus',Gservo);

%% 
% 9.18

%%
% Some light calculations to find gain, K for Skill-Assessment Exercise 9.2
x = -10.4988+j*17.398
K= -1*(x)*(7+x)*(x+25.52)/(x+10)
abs(K)
%% State Space Model
% 
% Creates a state-space model
A = [1 2; 3 4];
B = [0; 1];
C = [1, 0];
D = [0];
model = ss(A, B, C, D)

%%
% Nise example Tryit-3.2
A=[-4 -1.5;4 0];
B=[2 0]' ;
C=[1.5 0.625];
D=0;
T=ss(A,B,C,D);
T=tf(T)
%%
% Example from
% <http://home.hit.no/~hansha/documents/subjects/EE4107/exercises/solutions/Exercise%206%20-%20State-space%20models%20-%20Solutions.pdf>

%%
% \begin{align}
% & \dot{x_1}=x_2 \\
% & \dot{x_2}=-2x_1 \\
% & y =x_2 \quad \dot{x}= Ax + Bu
% \end{align}
%%
% Answer is:
%%
% \begin{align}
% & \dot{x}=\begin{bmatrix}\dot{x_1} \\ \dot{x_2}\end{bmatrix}=\begin{bmatrix}0 & 1 \\ -2 -1 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} + \begin{bmatrix}0 \\ 5\end{bmatrix} u \\
% & y = \begin{bmatrix}0 & 1 \end{bmatrix}\begin{bmatrix}x_1 \\ x_2
% \end{bmatrix} + 0 u
% \end{align} 
%%
% \begin{align}
% & \dot{x_1}=x_2 \\
% & \dot{x_2}=-x_1-3x_2+2u_1+4u_2 \\
% & y =x_1+u_2 \quad \dot{x}= Ax + Bu \quad y = Cx + Du
% \end{align}

%%
% Another Example.
%%
% \begin{align}
% & \dot{x}=\begin{bmatrix}\dot{x_1} \\ \dot{x_2}\end{bmatrix}=\begin{bmatrix}0 & 1 \\ -1 -3 \end{bmatrix}\begin{bmatrix} x_1 \\ x_2 \end{bmatrix} + \begin{bmatrix}0 & 0 \\ 2 & 4\end{bmatrix}\begin{bmatrix} u_1 \\ u_2 \end{bmatrix} \\
% & y = \begin{bmatrix}1 & 0 \end{bmatrix}\begin{bmatrix}x_1 \\ x_2
% \end{bmatrix} + \begin{bmatrix} 0 & 1 \end{bmatrix} \begin{bmatrix} u_1
% \\ u_2 \end{bmatrix}
% \end{align} 
%%
% Too lazy to type set the rest, don't really have the time anyway.
%%
% 
num = [1 7 2]; den = [1 9 26 24];
[A, B, C, D] = tf2ss(num,den)

%%
% 

A = [0 1 0; 0 0 1; -1 -2 -3]; B = [10; 0; 0];
C = [1 0 0]; D = [0];
[num, den] = ss2tf(A,B,C,D,1);
G = tf(num,den)

%%
% ECE356, final14.pdf
G5= tf([10000],[1,0,0])
bode(G5)
margin(G5);

%%
% Another question 4, from ECE 356
syms a EPS s K;
Stable = K*(s+a)+s*(s+1)*(s+2)*(s+3)
Stable = expand(Stable)
Test = [K*a,6+K,11,6,1];
ra=routh(Test,EPS)
simplify(ra)

% do matrix algebra

%%
% Ogata 2-A-14
num = [2 1 1 2];
den = [1 4 5 2];
[A,B,C,D] = tf2ss(num,den)
%% 
% Testing out third order and fourth order
syms a b c K EPS;
ra5 = routh([a b c K],EPS)
ra6 = routh([1 7 7 15 K],EPS)

%% Lead-Lag Compensation
% Dominant poles are the ones closest to the origin, 
% The poles near to origin of s-plane are the dominant poles for a stable system.

a = (-2+j*4.33)/(2.53+j*4.33)
rad2deg(angle(a))

%% Ogata Questions
%
Go1 = zpk([-2,-3],[0,-1],1)
rlocus(Go1)

%% Grunt work
% A𤖫5
phi=(-2+j*sqrt(6)+1/10)/(-2+j*sqrt(6)+1/200)
rad2deg(angle(phi))
% small angle contribution.

G2 = zpk([],[0,-2,-8],10)
G2 = feedback(G2,1)

%%
% Nyquist Plot Ogata Ex 7-18
G = zpk([-3],[0,1],1)
nyquist(G)


%%
% A-7-8
G56 = zpk([],[0,-1,-0.5],1)
nyquist(G56)
%%
% A-7-9
G567 = zpk([],[1],2)
nyquist(G567)
%%
% A-7-18 Matlab program
num = [20 20 10];
den = [1 11 10 0];
w1 = 0.1:0.1:10; w2 = 10:2:100; w3 = 100:10:500;
w = [w1 w2 w3];
[re,im,w] = nyquist(num,den,w);
plot(re,im)
v = [-3 3 -5 1]; axis(v);
grid
title('Nyquist Plot of G(s) = 20(s^2 + s + 0.5)/[s(s + 1)(s + 10)]')
xlabel('Real Axis')
%%
% A - 7 -14
num = [-1 -4 -6]
den = [1 5 4]
nyquist(num,den)

%%
% Nise Chapter 9 5, System 4
G56 = zpk([-5],[0,-3,-2*j,2*j],1)
nyquist(G56)
%%
% Ogata
K = [1,10]
for i=1:length(K)
    GTest = zpk([-0.5],[0,0,-2,-10],10*K(i))
    figure
    nyquist(GTest)
    figure
    nyquist(1/GTest)
end

%%
% B-7-12
G5 = tf([1],[1 0.8 1 0])
nyquist(G5)
%%
% B-7-13
G65=tf([1],[1,0.2,1,1])
roots([1,0.2,1,1])
nyquist(G65)

%%
% With two open loop poles on the RHP plane
% Z = N + P, N must be -2, aka counterclockwise encirclements around -1+ j0
% This is not true, so the system is unstable

%%
% B-7-14
G10 = tf([1,2,1],[1,0.2,1,1])
roots([1,0.2,1,1])
nyquist(G10)

%%
% Since the transfer function has two poles in the RHP, P =2, so Z = N + P
% N = -2, 2 counter clockwise encirclements are there, Z = 0, as expected
% for stability.

%%
% B-7-`8
K = [1,10,100]
for i=1:length(K)
    GTest = zpk([-2],[0,-1,-10],K(i))
    figure
    nyquist(GTest)
end

%%
%
syms s I1 I2 I3 V
A = [(2*s + 2) -(2*s + 1)...
-1
-(2*s + 1) (9*s + 1)...
-4*s
-1 -4*s...
(4*s + 1 + 1/s)];
B=[I1;I2;I3] ;
C=[V;0;0] ;
B=inv(A)*C;
pretty(B)

%%
% More testing
Gtest = tf([1 2], [1 -4 13])
rlocus(Gtest)
%%
% ELEC 360 Old finals
syms EPS K
K1 = 8.16
routh([1 5 8 6 K1],EPS)

% number 6
G16= zpk([],[-1,-3],1)
Geq1 = feedback(G16,1)
G18 = zpk([],[0],1)
Geq2 = feedback(Geq1*G18,1)

%%
% sys = feedback(sys1,sys2,+1)
% ELEC 360 2003
G1 = tf([1],[1 2])
G2 = tf([1],[1 0])
G3 = tf([1],[1 3])

Geq1 = feedback(G1,G2,+1)
Geq2 = feedback(Geq1,G3)

%%
% Bode Plot Gui
G66 = zpk([1],[-1,-2],1)
G56 = tf([1 -1],[1 3 2])
BodePlotGui(G56)
%%
% 
Grlocus = zpk([-2],[0,0,-10],1)
[num,den] = tfdata(Grlocus)
Gcool = tf(num,den)
RLocusGui(Gcool)

%%
%
G2 = zpk([-1],[0,-0.5,-2],1)
[num2,den2] =tfdata(G2)
G5 = tf(num2,den2)
BodePlotGui(G5)
figure
nyquist(G5)
%%
% 
G6 = (zpk([1],[-1,-0.5],1))
[num3,den3] =tfdata(G6)
G6b = tf(num3,den3)
BodePlotGui(G6b)
figure
%%
% 
Gtest = zpk([],[0,0,-6],1)
bode(Gtest,{0.01,100})
%%
% 2006, G1
G1 =zpk([-3],[-1,-5,-2],1)
bode(G1,{0.01,100})
nyquist(G1)
%%
%
G50 = zpk([-2],[1,-4],1)
rlocus(G50)
%%
% 
G=zpk([],...
[-5, -20, -50],10000)
bode(G)
grid on
%%
% Ogata B-7-27
K =1
G1 = zpk([],[0,-1],10)
G2 = zpk([-0.1],[-0.5],K)
Geq = G1 * G2
bode(Geq)

% setting to value of K to -15 = 20 log10 K so that the phase margin is 50
K = 10^(-11.5/20)
G2 = zpk([-0.1],[-0.5],K)
Geq2 = G1 * G2
figure
bode(Geq2)
margin(Geq2)

%%
% B-7-32
G1 = zpk([],[0,-1,-10],4)
bode(G1)

%%
% B-7-33
G1 = tf([2 0.1],[1 0.1 4 0])
bode(G1)
%%
% Skill-Assesmment problem 11.1
G5 = zpk([],[0,-50,-120],1)
bode(G5)