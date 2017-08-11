function h = lab3_363(N,Ts,wp,wa)
[p,q] = lab3_362(N,Ts,wp,wa)
x = inv(q)*p';
M = (N-1)/2;
h = 0.5*flipud(x); % this generates columns 1 through 11
h(M+1) = 0; % Set h(M+1) to zero ,cause matlab indices start at 1.
h(M+2:2*M+1)=-flipud(h(1:M)); %If N is 23, this goes from 13 to 23
%h = -h;
