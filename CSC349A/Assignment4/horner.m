function [b, c] = horner(x0, n, a)
    b(n+1)=a(n+1);
    c(n+1)=a(n+1);
    for j = n: -1: 2
        b(j) = a(j) + b(j+1)*x0;
        c(j) = b(j) + c(j+1)*x0;
    end
    b(1) = a(1) + b(2)*x0;
