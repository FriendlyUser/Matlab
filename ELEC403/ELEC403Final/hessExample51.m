function H = hessExample51(x)
x1 = x(1);
x2 = x(2);
h11 =  12*x1^2 - 5*x2^2*sin(x1*x2) - 16;
h12 =  5*cos(x1*x2) - 5*x1*x2*sin(x1*x2);
h21 =  5*cos(x1*x2) - 5*x1*x2*sin(x1*x2);
h22 =  12 - 5*x1^2*sin(x1*x2);
H = [h11 h12; h21 h22];