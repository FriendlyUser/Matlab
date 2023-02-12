function H = freqResp(a,b,w)
    % create bounds of summation
    M = length(a);
    N = length(b);
    
    H = length(w);
    Y = length(w);
    X = length(w);
    W = length(w); %iterate for all elements of W
    top = zeros(1,M);
    bottom = zeros(1,M);
    for j = 1:W
        % compute the summation of ak * w^k 
        for k = 1:M 
            top(k) = a(k) * w(j).^k
        end
        
        % compute the summation of ak * w^k 
        for k = 1:N 
            bottom(k) = b(k) * w(j).^k
        end
        Y(j) = sum(top)
        X(j) = sum(bottom)
        H(j) = Y(j)./X(j)
    end
end