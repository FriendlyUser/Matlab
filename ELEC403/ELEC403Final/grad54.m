function z = grad54(x)
x1 = x(1); 
x2 = x(2); 
g1 = 10*x1 - 9*x2 + 1;
g2 = (163*x2)/20 - 9*x1;
z= [g1;g2];