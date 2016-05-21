function [u] = unitstep(t)
    % create a zero vector that has the same length as t
    d=length(t);
    u = zeros(1,d);

    % go through each element of t and set it to 1 or 0
    for i=1:d
        if(t(i) >= 0) 
            u(i) = 1;
        else
            u(i) = 0;
        end
    end