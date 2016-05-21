% n the polynomial degree
% a (a vector of the coefficients of the polynomial)
% x0 the initial approximation to a zero
% eps relative error tolerance used to test for convergence
% imax the maximum number of iterations allowed

%root the final computed approximation to a zero of f(x)
% b the final vector of values b computed by Horner’s algorithm,
% from which the deflated polynomial can be obtained.




function [root,b] = polyNewton ( n, a, x0, imax, eps )
    i = 1;
    fprintf( 'iteration   approximation\n' );
    while (i <= imax)
        [b,c] = horner( x0, n, a );
        root = x0 - b(1)/c(2);
        fprintf( '%6.0f %18.10f\n', i, root );
        if abs( 1-x0/root ) < eps
             return
        end
        i = i+1;
        x0 = root;
    end
    fprintf( 'failed to converge in %g iterations\n', imax );
end