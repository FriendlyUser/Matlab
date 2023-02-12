X = linspace(-5,5,10);
Y = (11.3*cos(0.3*pi*X+0.6*pi));
stem(X,Y,'filled');
hold on
t = linspace(-5,5,400);
X1 = (11.3*cos(1200*pi*t+0.6*pi));
plot(t,X1);
X2 = (11.3*cos(6800*pi*t+0.6*pi));
plot(t,X2);
X3 = (11.3*cos(8200*pi*t+0.6*pi));
plot(t,X3);
%X2 = (11.3*cos(2400*pi*t+0.6*pi));
%plot(t,X2);

