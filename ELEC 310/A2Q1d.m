x=-100:0.1:100;
s1= cos(300*10^6*pi*(x / (3 * 10^8)) - (sqrt(x.^2+10.^6)+55)/(3*10^8));
s2= cos(300*10^6*pi*(x / (3 * 10^8)) - (sqrt((x.^2-55).^2+10.^6)+55)/(3*10^8));
r=s1+s2;
plot(x,r)
xlabel({'$-100 \leq x \leq 100$'},'Interpreter','latex');
ylabel('Signal Strength');
title('Problem 2.28 d');

