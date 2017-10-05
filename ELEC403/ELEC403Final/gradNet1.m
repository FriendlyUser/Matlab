function g = gradNet1(x)
x1= x(1);
x2 =x(2);
g1 = 4*x1;
g2 = 20*x2;
g = [g1; g2];