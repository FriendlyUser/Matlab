%input must be lower triangular matrix
function x = forSub (A, b)
    n = size(A,1);
    % fill x with zeroes
    x = zeros(n,1);
    % solve for x(1)
    x(1) = b(1) / A(1,1);
    for i = 2:n
        sum = b(i);
        for j = 1:i-1
             % forward substitution
             sum = sum - A(i,j)*x(j);
        end
        % solve for x(i)
        x(i) = sum / A(i,i);
    end

