n= [0 1 2 6 7 11 21 51];
z=exp(j*0.3*pi*n+0.2*pi);
stem(n,z,'filled')
title({'Selected points for $z=e^{j0.3\pi n + 0.2 \pi}$'},'Interpreter','latex');
print('A3Q3', '-dpng', '-r600'); %<-Save as PNG with 600 DPI