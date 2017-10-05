%% Author: DAVID LI
%  FinalPrep.m --- ELEC 403 Final exam, this matlab file is used to do the
%  various problems in the ELEC 403 textbook that are related to the final
%  exam, of course the focus is on chapter 5 and chapter 7.

%% Prob 5.2 with jacobian f(x) = x^2+2*y^2+4*x+4*y
% * REMEMBER THAT CHAPTER 5 only has SDM, Newton and Gauss-Newton*
syms x_1 x_2 
f = x_1^2+2*x_2^2+4*x_1+4*x_2;
latex(f);
g=gradient(f);
latex(g);
f1 = x_1+2;
f2 = sqrt(2)*(x_2+1);
j=jacobian([f1,f2],[x_1,x_2]);
h = hessian(f);
%steep_desc3('func52','grad52',[-1; 1],1e-3);
gauss_newton('func52','grad52','jacob52',[-1; 1],1e-3);

%% Prob 5.2 with Newton
newton('func52','grad52','hess52',[0; 0],0.1,1e-3);

%% Prob 5.2 with dfp
dfp('func52','grad52',[0; 0],1e-6);

%% Prob 5.2 with dfp
bfgs('func52','grad52',[0; 0],1e-6);
%% Prob 5.4 -- Find a good starting point besides x0 = [1 1]
syms x_1 x_2 
f = 5*x_1^2-9*x_1*x_2+4.075*x_2^2+x_1;
latex(f);
g = gradient(f);
latex(g);
steep_desc3('func54','grad54',[-16; -17.9],1e-3);
h = hessian(f);

%% 5.4 Using Newton
h = hessian(f);
latex(h)
newton('func54','grad54','hess54',[-10; -5],0.1,1e-6);

%% 5.4 Using Gauss Newton
j = jacobian(f,[x_1,x_2]);
gauss_newton('func54','grad54','jacob54',[-16; -18],1e-3);

%% Prob 5.4 with dfp
dfp('func54','grad54',[0; 0],1e-6);

%% Prob 5.4 with bfgs
bfgs('func54','grad54',[0; 0],1e-6);
%% Prob 5.5 -- use a closer point so that it can be done manually
% Produce the latex needed for final exam review document
syms x_1 x_2 x_3
f = (x_1+5)^2+(x_2+8)^2+(x_3+7)^2+2*x_1^2*x_2^2+4*x_1^2*x_3^2;
latex(f)
g = gradient(f);
latex(g)

steep_desc3('func55','grad55',[0; -8; -7],1e-3)

%% Chapter 7, using Prob 5.2 with DFP
% * REMEMBER THAT CHAPTER 7 only has DFP and BFGS*
% * DFP
% * BFGS 
dfp('func52','grad52',[-1; 1],1e-6);


%% Chapter 7, using Prob 5.2 with BFGS
bfgs('func52','grad52',[-1; 1],1e-6);

%% Examples from the Internet --- Using DFP
% $f(x)=-2*x_1^2-10*x_2^2$
dfp('funcNet1','gradNet1',[1; -1],1e-3);

%% USING BFGS
bfgs('funcNet1','gradNet1',[-1; 1],1e-6);

%% Using Gauss-Newton
gauss_newton('funcNet1','gradNet1','jacobNet1',[1; -1],1e-3);

%% Examples copied from the course notes and other 
steep_desc3('funcExample51','gradExample51',[1;-1],1e-3)

%% Examples copied from the course notes and other 
format long
newton('funcExample51','gradExample51','hessExample51',[2;-1],0.1,1e-3);

%% Examples copied from the course notes and other 
format long
dfp('funcExample51','gradExample51',[2;-1],1e-3);

%% Jacobian example from notes 
syms x1 x2
f1 = x1^2-x2^2+x1-3*x2-2;
f2 = x1^3-x2^4+2;
f3 = x1^2+x2^3+2*x1-x2+1.1;
j = jacobian([f1 f2 f3], [x1,x2]);
j';
gauss_newton('funcExample52','gradExample52','jacobExample52',[2; -2],1e-3);