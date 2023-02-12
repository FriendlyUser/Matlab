function y = mysinc(x)
    % mysinc - Compute the sinc function (as defined in the lecture notes)
    % sinc(x) returns a matrix whose elements are the sinc of the
    % elements of x
    % Initialize the output array to all ones.
    y = ones(size(x));
    % Determine the indices of all nonzero elements in the input array.
    i = find(x);
    % Compute the sinc function for all nonzero elements.
    % The zero elements are already covered, since the output
    % array was initialized to all ones above.
    y(i) = sin(x(i)) ./ (x(i));
return
