function out = RemoveHum( x , omega0 , rho )
%RemoveHum( x , omega0 , rho )
% out = RemoveHum( x , omega0 , rho)
% Applies filter to input x with parameters omega0 and rho.
 b = [1 -2*cos(omega0) 1]; %feedforward coefficients
 a = [1 -2*rho*cos(omega0) rho^2]; %feedback coefficients
 out = filter(b,a,x);
 