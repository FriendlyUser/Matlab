n= [0 1 2 4 14];
z=exp(j*(pi/15)*n.^2);
stem(n,z,'filled')
title('Chirp Signal')
xlabel('n')
ylabel({'$z=e^{j(\pi/15)n^{2}}$'},'Interpreter','latex');
print('A3P425', '-dpng', '-r600'); %<-Save as PNG with 600 DPI