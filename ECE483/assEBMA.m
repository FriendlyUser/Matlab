% ELEC 483  
% Problem 6.12 from the textbook
% Block Motion Estimation using Exhaustive Search.
% 
% Input:   s_range -- search range
%                N -- block size
% Output: dmi, dmj -- displacement vector
% 
% For example, you may type "[dmi,dmj] = assignment2([8,8],16);" 
% in the commend window, then it will return the EBMA results 
% with block size 16 by 16, and search range 8 in both directions.

function [dmi,dmj] = assignment2(s_range,N)

ri = s_range(1);
rj = s_range(2);

anchor = imread('train01.tiff');
target = imread('train02.tiff');

figure
subplot(2,2,1)
imshow(anchor)
hold on

[m,n] = size(anchor);
anchor = double(anchor);
target = double(target);

% For each block, calculate the minimal error and its associated 
% displacement vector
for i = 1:1:m/N
    for j = 1:1:n/N
        i1 = (i-1)*N + 1;
        j1 = (j-1)*N + 1;
        e = 1000000;
        for k = max(1,i1-ri):1:min(m-N+1,i1+ri)
            for l = max(1,j1-rj):1:min(n-N+1,j1+rj)
                et = sum(sum(abs(target(k:k+N-1,l:l+N-1)-...
                    anchor(i1:i1+N-1,j1:j1+N-1))));
                if et < e
                    e = et;
                    dmi(i,j) = k - i1;
                    dmj(i,j) = l - j1;
                end
            end
        end
        predict_image(i1:i1+N-1,j1:j1+N-1) = target(dmi(i,j)+...
            i1:dmi(i,j)+i1+N-1, dmj(i,j)+j1:dmj(i,j)+j1+N-1);
    end
end

error_image = predict_image - anchor;
psnr = 10*log10(255*255/mean(mean((error_image.^2))))

[i,j] = meshgrid((N+1)/2:N:n,(N+1)/2:N:m);
quiver(i,j,dmj,dmi)
title('Anchor frame with motion field')
hold off

subplot(2,2,2)
dmi = -flipud(dmi);
dmj = flipud(dmj);
quiver(i,j,dmj,dmi)
axis([0 n 0 m]);
title(sprintf('Motion field, search range [%d, %d]',ri,rj))

subplot(2,2,3)
imshow(uint8(predict_image))
title(sprintf('Predicted image (PSNR = %.4f)', psnr))

subplot(2,2,4)
imshow(uint8(255 - abs(error_image)))
title('Prediction-error image (complement)')