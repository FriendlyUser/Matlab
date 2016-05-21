fplot('0.5403*(x^2-8*x+12)/5',[0,8],':');
hold on
fplot('(0.4161)*(x^2-7*x+6)/4',[0,8],'-');
fplot('0.9602*(x^2-3*x+2)/20',[0,8],'--');
title('L_{0}(x)f(x_{0}),  L_{1}(x)f(x_{1}),  L_{2}(x)f(x_{2}) from [0, 8]')
legend('y = 0.10806(x^2-8*x+12)','y = 0.104025(x^2-7*x+6)','y = 0.04801(x^2-3*x+2)')

x = 0:0.1:8;
y = cos(x);
plot(x,y)
title('cosine of x');
hold on

Marked = [1 cos(1); 2 cos(2); 6, cos(6);];

fplot('cos(x)', [0,8],'-')
hold on
fplot('0.5403*(x^2-8*x+12)/5+(0.4161)*(x^2-7*x+6)/4+0.9602*(x^2-3*x+2)/20',[0,8],'--');

Marked = [1 cos(1); 2 cos(2); 6, cos(6);];
plot(Marked(:,1),Marked(:,2),'*');
legend('f(x)= cos(x)', 'P(x)=0.260095x^{2}-1.73669x+2.01689','Marked points [1, 0.5403], [2, -0.4161], [6, 0.9602]')
title('Graph of cos(x) and stars, sum of L_{0}(x)f(x_{0}), L_{1}(x)f(x_{1}), and L_{2}(x)f(x_{2}) ')

x1 = 1;
y1 = 0.5403;
str1 = '  \leftarrow P(1) = 0.5403';
text(x1,y1,str1)

x2 = 2;
y2 = -0.4161;
str2 = '  \leftarrow P(2) = -0.4161';
text(x2,y2,str2)

x3 = 6;
y3 = 0.9602;
str3 = '  \leftarrow P(6) = 0.9602 ';
text(x3,y3,str3)


X = [1 2 5 6 7 9 10 13 17];
Y = [1.67 3 4.7 3.9 2.8 5.7 6.6 7.5 6.7 3.2 -1.25];
pp = spline(X,Y);
[b,c] = unmkpp(pp)




for i = 1:8, x(i,:) = linspace(b(i),b(i+1),50); 
    end
for i = 1:8,y(i,:) = c(i,1)*(x(i,:)-b(i)).^3 + ...
    c(i,2)*(x(i,:)-b(i)).^2 + ...
    c(i,3)*(x(i,:)-b(i)) + ...
    c(i,4);
    end
for i = 1:4,plot( x(2*i-1,:),y(2*i-1,:),':',x(2*i,:),y(2*i,:),'-');
hold on;
end
title('PIECEWISE POLYNOMIALS');
legend('1','2','3','4','5','6,','7','8','Location','south');