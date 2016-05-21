function [u] = FAILstep(t)
% create a zero vector that has the same length as t
d=length(t);
u = zeros(1,d);
% case t(i) >= 0
if(t(1) >= 0) 
    u(1) = 1;
% case t(1) < 0
else
    u(1) = 0;
end
