% Sampling frequency
clear all
fs = 44100;
% Frequencies to evaluate response for
f = 0:0.005:200;
% Values for rho from the assignment
rho = [0.75 0.9 0.99 0.9999];
for i=1:length(rho)
% Compute frequency response.
    b = [1 -2*cos(2*pi*60 / fs) 1]; %feedforward coefficients
    a = [1 -2*rho(i)*cos(2*pi*60 / fs) rho(i)^2]; %feedback coefficients
    hold on
    [H,w] = freqz(b,a,f,fs);
    % Plot magnitude response
    legendPlotName = sprintf('p = %0.4f', rho(i));
    plot(w,abs(H),'DisplayName',legendPlotName,'LineWidth',2);
end 
    legend('show')
    xlabel('Frequency (Hz)');
    ylabel('Magnitude |H(e^{j \omega})|');
    titlename =sprintf('Frequency Response for different values of p');
    title(titlename);
    filename = sprintf('Ass10P5Pic%d', 51);
    %print(filename,'-dpng','-r600')

%% Old way to plot functions
for i=1:length(rho)
% Compute frequency response.
    b = [1 -2*cos(2*pi*60 / fs) 1]; %feedforward coefficients
    a = [1 -2*rho(i)*cos(2*pi*60 / fs) rho(i)^2]; %feedback coefficients
    hold on
    H = freqz(b,a,f,fs);
    % Plot magnitude response
    plot(f,abs(H));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude |H(e^{j \omega})|');
    titlename =sprintf('Frequency Response of Filter for p = %0.4f', rho(i));
    title(titlename);
    filename = sprintf('Ass10P5Pic%d', i);
    print(filename,'-dpng','-r300')
end 

%% part e
[x,fs] = audioread('noisy.wav');
omega0 = 2*pi*60 / fs;
rho =0.75;
y=RemoveHum(x,omega0,rho);
soundsc(y,fs);
audiowrite('rho0_75.wav',y,fs);

rho =0.9;
y=RemoveHum(x,omega0,rho);
soundsc(y,fs);
audiowrite('rho0_9.wav',y,fs);

rho =0.99;
y=RemoveHum(x,omega0,rho);
soundsc(y,fs);
audiowrite('rho0_99.wav',y,fs);

rho =0.9999;
y=RemoveHum(x,omega0,rho);
soundsc(y,fs);
audiowrite('rho0_9999.wav',y,fs);