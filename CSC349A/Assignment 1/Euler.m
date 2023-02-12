function [times, velocities] = Euler(m,c,g,t0,v0,tn,n)
    % print headings and initial conditions
%     fprintf('values of t approximations v(t)\n')
%     fprintf('%8.3f',t0),fprintf('%19.4f\n',v0)
    times = zeros(1,n);
    velocities = zeros(1,n);
    i=1;
    % compute step size h
    h=(tn-t0)/n;
    % set t,v to the initial values
    times(1)=t0;
    velocities(1)=v0;
    % compute v(t) over n time steps using Euler's method
    for i=1:n
        velocities(i+1) = velocities(i) +(g-c/m*velocities(i))*h;
        times(i+1) = times(i) + h;
%        fprintf('%8.3f',t),fprintf('%19.4f\n',v)
    end

