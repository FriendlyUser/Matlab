function [times total] = EulerCompound(r,P0,t0,tn,n)
    % print headings and initial conditions
%     fprintf('values of t approximations v(t)\n')
%     fprintf('%8.3f',t0),fprintf('%19.4f\n',v0)

    i=1;
    % compute step size h
    h=(tn-t0)/n;
    times = zeros(1,n);
    total = zeros(1,n);
    % set money to the initial values
    total(1) = P0;
    times(1) = t0;
    % compute P(t) over n time steps using Euler's method
    for i=1:n
        total(i+1) = total(i) + h*r*total(i);
        times(i+1) = times(i) + h;
%        fprintf('%8.3f',t),fprintf('%19.4f\n',v)
    end

