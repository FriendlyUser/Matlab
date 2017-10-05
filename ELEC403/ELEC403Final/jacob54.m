function z = jacob54(x)
x1 = x(1);
x2 = x(2);
z1 = 10*x1 - 9*x2 + 1;
z2 = (163*x2)/20 - 9*x1;
z= [z1 z2];