b= [1 0 0 0 0 0 0 -1] %numerator polynomial
a = [1 -1]; % denominator polynomial
w = linspace(0,2*pi); % plot from 0 to 2 pi
% Plot the phase response and plot the magnitude response in Db
freqz(b,a,w); % plot frequency response
print('814FreqResp','-dpng','-r300')