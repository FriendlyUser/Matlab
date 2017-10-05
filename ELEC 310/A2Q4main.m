t=-1:0.01:1;
x=2/(pi^2)*exp(j*2*pi*t);
plot(t,x)
hold on
t=-1:0.01:1;
x=2/(pi^2)*exp(j*2*pi*t)+ 2/(9*pi^2)*(exp(j*2*pi*3*t));
plot(t,x)
hold on 
t=-1:0.01:1;
x=2/(pi^2)*exp(j*2*pi*t)+ 2/(9*pi^2)*(exp(j*2*pi*3*t))+2/(25*pi^2)*(exp(j*2*pi*5*t));
plot(t,x)
hold on
t=-1:.001:1; 
x = 0.25 * sawtooth (pi * 2 * (t-0.5)  , 0.5); 
plot(t,x);
legend('K=1', 'K=3','K=5','Triangle Wave')
title('Truncated Fourier Series using calculated coefficients');
print('A2Q4GOOD', '-dpng', '-r600'); %<-Save as PNG with 600 DPI

