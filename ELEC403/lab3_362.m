%% This function computes p and Q given N, Ts, wp, wa as inputs using numerical integration
function [p,q] = lab3_362(N,Ts,wp,wa)
M = (N-1)/2;
%% Compute p
for i=1:M
    p(i)=1/Ts*quad(@(x)lab3_p(x,i),0,wp);
end
%% Compute q
for i=1:M
    for j=1:M
        t = [i j];
%         if i==j
%             q(i,j)= integral(@(x)lab3_q2(x,t),0,wp)+integral(@(x)lab3_q2(x,t),wa,pi);
%         else 
            q(i,j) = quad(@(x)lab3_q(x,t),0,wp)+quad(@(x)lab3_q(x,t),wa,pi);
%         end 
    end
end
