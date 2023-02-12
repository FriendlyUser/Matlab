x = [0 1 1 1];
h = [2 -1 -1];
t =0:5;
y = conv(x,h)
stem(t,y)
xlabel('n')
ylabel('y[n]')
title('Convolution of x[n] and h[n]')
print('Prob85','-dpng','-r300')

%% Prob 8.5 dVersion 2 evaluation
N = 6
for k = 0:N-1
     Y(k+1)=-exp(-j*10*pi*k/N)-2*exp(-j*8*pi*k/N)+exp(-j*4*pi*k/N)+2*exp(-j*2*pi*k/N);
end
y=ifft(Y)

%% Prob 8.5 d
N = 4
for k = 0:N-1
     Yd(k+1)=-exp(-j*0.5*pi*k)-2+exp(-j*4*pi*k/4)+2*exp(-j*2*pi*k/4);
end
yd=ifft(Yd);
