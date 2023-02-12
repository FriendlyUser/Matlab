function Fourier()
clear all
for n = [1 5 10 50 100]
    % Sum terms
    syms k w 
    f = symsum(sym('0.5 * mysinc(pi * k / 2) * exp(j * k * w * t)'),...
        k, -n , n);
    % Plot the sum
    ezplot(subs(f,w, 2 * pi), [-1 1]);
    % label the graph
    title(sprintf('x_{%d}(t)', n));
    % advance to the next figure on keypress
    w = waitforbuttonpress;
    % print the picture to a file
    print(sprintf('x_{%d}(t)', n), '-dpng');
end
 