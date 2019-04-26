% Question 9.9 from the textbook

function ex9_9

cimage = input('Enter name of image: ','s');
im = imread(cimage);

% im = imread('lena.tiff');

% Scale factor: 0.5
[im_r,N,psnr] = quan9_9(im,0.5);
figure
imshow(uint8(im_r));
title(sprintf('Scale factor: 0.5 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_0

% Scale factor: 1
[im_r,N,psnr] = quan9_9(im,1);
figure
% subplot(232)
imshow(uint8(im_r))
title(sprintf('Scale factor: 1 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_1

% Scale factor: 2
[im_r,N,psnr] = quan9_9(im,2);
figure
% subplot(233)
imshow(uint8(im_r))
title(sprintf('Scale factor: 2 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_2

% Scale factor: 4
[im_r,N,psnr] = quan9_9(im,4);
figure
% subplot(234)
imshow(uint8(im_r))
title(sprintf('Scale factor: 4 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_4

% Scale factor: 8
[im_r,N,psnr] = quan9_9(im,8);
figure
imshow(uint8(im_r))
title(sprintf('Scale factor: 8 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_8

% Scale factor: 16
[im_r,N,psnr] = quan9_9(im,16);
figure
imshow(uint8(im_r))
% title('Scale factor: 16')
title(sprintf('Scale factor: 16 (PSNR = %.4f, %d nonzero coefficients)',...
    psnr, N))
print -deps2 lena_sf_16


% Compute the reconstructed image with  different scale factors
% input:    im -- original image
%           sf -- scale factor
% output: im_r -- reconstructed image
%            N -- number of nonzero coefficients
%         psnr -- psnr of the reconstructed image

function [im_r,N,psnr] = quan9_9(im,sf)

im = double(im);

q = [16  11  10  16  24  40  51  61; 
     12  12  14  19  26  58  60  55; 
     14  13  16  24  40  57  69  56; 
     14  17  22  29  51  87  80  62; 
     18  22  37  56  68 109 103  77; 
     24  35  55  64  81 104 113  92; 
     49  64  78  87 103 121 120 101; 
     72  92  95  98 112 100 103  99];  

im_q = blkproc(im,[8,8],'round(dct2(x)./P1).*P1',q*sf);
N = length(find(im_q ~= 0));
% N_a = N / ((512/8)^2);
im_r = blkproc(im_q,[8,8],'idct2');
psnr = 10*log10(255*255/mean(mean((im - im_r).^2)));