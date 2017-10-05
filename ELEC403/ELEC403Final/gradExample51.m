function g = gradExample51(x)
x1 = x(1);
x2 = x(2);
g1 =  5*x2*cos(x1*x2) - 16*x1 + 4*x1^3 - 8;
g2 =  12*x2 + 5*x1*cos(x1*x2);
g = [g1; g2];