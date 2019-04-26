
% ELEC 483

% 2-D Fourrier Transform
% demo_FT.m

% Enter the name of the image 
% for example,  lena.tif, man.tif

timage=input('Enter name of image: ','s')

clear Xrgb1 Xrgb z zz zzz pppr

[Xrgb1]=imread(timage) ; 
Xrgb=double(Xrgb1(:,:,1));


%   Discrete Fourier Transform of image

z= fft2(Xrgb);
zz=fftshift(z);
zzz=abs(zz);
ppp=angle(zz);

%  Display the image

imshow(timage)

%  Display the magnitude

figure
subplot(121)
mesh(log10(zzz)); colormap(jet);
zlabel('Log. of |DFT|')

subplot(122)
imshow(log10(zzz), []); colormap(jet);
xlabel('Log. of |DFT|')


% Display the phase 

figure
mesh((ppp)*180/pi); colormap(jet);

% Unwrap the phase in both dim and display

figure
mesh(unwrap(unwrap(ppp')')*180/pi); colormap(jet);

