%% Prob 8.3 a)
n = 1:12;
y1 = 3*(-1).^n;
N = length(y1);
Y1 = zeros(12,1);
for k = 0:N-1
    for n = 0:N-1
        Y1(k+1) = Y1(k+1) + y1(n+1)*exp(-j*pi/6*n*k);
    end
end
%% Prob 8.3 b)
y2(1:4) = 1;
y2(5:12) = 0;
N = length(y2);
Y2 = zeros(12,1);
for k = 0:N-1
    for n = 0:N-1
        Y2(k+1) = Y2(k+1) + y2(n+1)*exp(-j*pi/6*n*k);
    end
end
%% Prob 8.3 c)
y3(2:2:12)= 0;
y3(1:2:12) = 1;
N = length(y3);
Y3 = zeros(12,1);
for k = 0:N-1
    for n = 0:N-1
        Y3(k+1) = Y3(k+1) + y3(n+1)*exp(-j*pi/6*n*k);
    end
end
format short
diary on
diary Prob83.csv
fprintf('Y1,Y2,Y3\n')
for k = 0:N-1
    fprintf('%3s,%3s,%3s\n',num2str(Y1(k+1)),num2str(Y2(k+1)),num2str(Y3(k+1))) 
end
diary OFF

%% Checking results
% t = 0:N-1
% subplot(311)
% stem(t,x);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Time domain - Input sequence')
% 
% subplot(312)
% stem(t,X)
% xlabel('Frequency');
% ylabel('|X(k)|');
% title('Frequency domain - Magnitude response')
% 
% subplot(313)
% stem(t,angle(X))
% xlabel('Frequency');
% ylabel('Phase');
% title('Frequency domain - Phase response')
% 
% X         % to check |X(k)|
% angle(X)  % to check phase