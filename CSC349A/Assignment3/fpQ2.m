function y = fpQ2(x)
    y=-1.00/(2.00*x^(3/2))-(182.64*10^(-6))/(x^(3/2) ...
        *(81.08*10^(-6)+(182.64*10^(-6))/sqrt(x))*log(10.00));