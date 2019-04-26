
%  ELEC 483

%  Colour Models, RGB <-> YCbCr
%  demo_CM.m

% Enter the name of the image 
% for example,  fruits.tif, peppers.tif

cimage=input('Enter name of image: ','s')

clear Xrgb Xr Xg Xb Ycbcr cb cr

[Xrgb]=imread(cimage);
Xrgb=double(Xrgb);

% Display the original color image
% and the R-G-B componnents

subplot(221)
imshow(uint8(Xrgb))
xlabel('Original image')

subplot(222)
Xr=zeros(size(Xrgb));Xr(:,:,1)=Xrgb(:,:,1);
imshow(uint8(Xr))
xlabel('R-component')
Xg=zeros(size(Xrgb));Xg(:,:,2)=Xrgb(:,:,2);

subplot(223)
imshow(uint8(Xg))
xlabel('G-component')
Xb=zeros(size(Xrgb));Xb(:,:,3)=Xrgb(:,:,3);

subplot(224)
imshow(uint8(Xb))
xlabel('B-component')

% Transform from RGB to YCbCr colormodel

Ycbcr= rgb2ycbcr(Xrgb);

% Display the original color image
% and the Y-Cb=Cr C0mponents

figure
subplot(221)
imshow(uint8(Xrgb))
xlabel('Original image')

subplot(222)
imshow(uint8(Ycbcr(:,:,1)))
xlabel('Y-component')

subplot(223)
mmin=min(min(Ycbcr(:,:,2))) 
cb=Ycbcr(:,:,2)- mmin;
imshow(uint8(cb))
xlabel('Cb-component, Shifted to display neg values')

subplot(224)
mmin=min(min(Ycbcr(:,:,3))) 
cr=Ycbcr(:,:,3)- mmin;
imshow(uint8(cr))
xlabel('Cr-component, Shifted to display neg values')

