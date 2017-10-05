t=-1:0.01:1;
subplot(3,1,1)
plot(t,2/(pi^2)*exp(j*2*pi*t))
title('K=1') 
subplot(3,1,2)
plot(t,2/(pi^2)*exp(j*2*pi*t)+ 2/(9*pi^2)*(exp(j*2*pi*3*t)))
title('K=3') 
subplot(3,1,3)
plot(t,2/(pi^2)*exp(j*2*pi*t)+ 2/(9*pi^2)*(exp(j*2*pi*3*t))+2/(25*pi^2)*(exp(j*2*pi*5*t)));
title('K=5');
print('A2Q4sub', '-dpng', '-r600'); %<-Save as PNG with 600 DPI