% Program: steep_desc3.m
% Title: Steepest-descent algorithm
% Description: Implements the steepest-descent method
% (Algorithm 5.1) using the inexact line search
% algorithm implemented in terms of Algorithm 4.6.
% Theory: See Practical Optimization Sec. 5.2.2.
% Input:
% fname: objective function
% gname: gradient of the objective function
% x0: initial point
% epsi: optimization tolerance
% Output:
% xs: solution point
% fs: objective function evaluated at xs.
% k: number of iterations at convergence
% Example:
% Find the minimum of the Himmelblau function
% f = (x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2
% using an initial point x0 = [6 6]' and termination
% tolerance epsi = 1e-6.
% Solution:
% Execute the command
% [xs,fs,k] = steep_desc3('f_himm','g_himm',[6 6]',1e-6)
% Notes:
% 1. The program can be applied to any customized function
% by defining the function of interest and its gradient
% in m-files.
% ========================================================
function [xs,fs,k] = steep_desc3(fname,gname,x0,epsi)
disp(' ')
disp('Program steep_desc3.m')
k = 1;
i=1;
fprintf('------- ITERATION 1 ------\n')
fprintf('STEP 1\n')
xk = x0
fprintf('STEP 2\n')
gk = feval(gname,xk)
dk = -gk
fprintf('STEP 3\n')
ak = inex_lsearch(xk,dk,fname,gname);
fprintf('Alpha: %3.9f \n', ak)
adk = ak*dk;
er = norm(adk);
fprintf('STEP 4\n')
fprintf('\n')
while er >= epsi,
xk = xk + adk
i = i +1;
fprintf('------- ITERATION %d ------\n',i)
fprintf('STEP 2\n')
gk = feval(gname,xk)
dk = -gk
fprintf('STEP 3\n')
ak = inex_lsearch(xk,dk,fname,gname);
fprintf('Alpha: %3.9f \n', ak)
adk = ak*dk;
er = norm(adk);
k = k + 1;
fprintf('STEP 4\n')
end
format long
disp('Solution point:')
xs = xk + adk
disp('Objective function at the solution point:')
fs = feval(fname,xs)
format short
disp('Number of iterations performed:')
k