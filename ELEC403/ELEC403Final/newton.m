% Program: newton.m
% Title: Newton algorithm
% Description: Implements the Newton algorithm
% described in Algorithm 5.3. Step 2 is
% is carried out by using Eq.(5.13).
% Theory: See Practical Optimization Sec. 5.3.
% Input:
% fname: objective function
% gname: gradient of the objective function
% hname: Hessian of the objective function
% dt: a small potive number
% x0: initial point
% epsi: termination tolerance
% Output:
% xs: solution point
% fs: objective function evaluated at xs.
% k: number of iterations at convergence
% Example:
% Find the minimum of the Himmelblau function
% f = (x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2
% with initioal point x0 = [6 6]' and termination tolerance
% epsi = 1e-6.
% Solution:
% Execute the command
% [xs,fs,k] = newton('f_himm','g_himm','h_himm',[6 6]',0.1,1e-6)
% Notes:
% 1. The program can be applied to any customized function
% by defining the function of interest and its gradient and
% Hessian in m-files.
% ================================================================
function [xs,fs,k] = newton(fname,gname,hname,x0,dt,epsi)
disp(' ')
disp('Program newton.m')
k = 1;
i =1;
fprintf('------- ITERATION 1 ------\n')
fprintf('STEP 1\n')
xk = x0
fprintf('STEP 2\n')
gk = feval(gname,xk)
Hk = feval(hname,xk)
[V,D] = eig(Hk);
di = diag(D);
dmin = min(di);
if dmin > 0,
Hki = V*diag(1./di)*V'
else
bt = dt - dmin;
Hki = V*diag((1+bt)./(di+bt))*V'
end
fprintf('STEP 3\n')
dk = -Hki*gk
fprintf('STEP 4\n')
ak = inex_lsearch(xk,dk,fname,gname);
fprintf('Alpha: %3.9f \n', ak);
adk = ak*dk;
er = norm(adk)
fprintf('STEP 5\n')
while er >= epsi,
xk = xk + adk
i = i +1;
fprintf('------- ITERATION %d ------\n',i)

fprintf('STEP 2\n')
gk = feval(gname,xk)
Hk = feval(hname,xk)
[V,D] = eig(Hk);
di = diag(D);
dmin = min(di);
fprintf('STEP 3\n')
if dmin > 0,
Hki = V*diag(1./di)*V'
else
bt = dt - dmin;
Hki = V*diag((1+bt)./(di+bt))*V'
end
dk = -Hki*gk
fprintf('STEP 4\n')
ak = inex_lsearch(xk,dk,fname,gname);
fprintf('Alpha: %3.9f \n', ak)
fprintf('STEP 5\n')
adk = ak*dk
er = norm(adk);
k = k + 1;
end
format long
disp('Solution point:')
xs = xk + adk
disp('Objective function at the solution point:')
fs = feval(fname,xs)
format short
disp('Number of iterations performed:')
k