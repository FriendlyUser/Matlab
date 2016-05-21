function x = forwardSub (A, b)
    n = size(A,1);
    x = zeros(n,1);
    x(1) = b(1) / A(1,1);
    for i = 2:n
        sum = b(i);
        for j = 1:i-1
             sum = sum - A(i,j)*x(j);
        end
        x(i) = sum / A(i,i);
    end

