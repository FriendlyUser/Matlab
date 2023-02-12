% Load the smeared image
[X,map] = imread('assignment.png');
[rows,cols] = size(X);
xrecover = zeros( rows , cols );
alpha = 0.01;
smeared_image ( 1:rows , 1 : cols ) = double(X);
% Recover the orignal
for m=1:rows,
    % Standard difference calculation for other rows
    for n=2:cols,
        xrecover(m,n) = smeared_image(m,n)-smeared_image(m,n-1) + ...
            xrecover(m,n-1) - (alpha * xrecover(m,n-1));
    end 
end 
% Display the recovered image.
imagesc(xrecover);
axis equal;
colormap('gray');
