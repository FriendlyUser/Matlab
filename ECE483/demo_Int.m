% ELEC 483

% Extracting the two fields from an interleced
% image and computing the Fourier Transform
% demo_Int.m

% Enter the name of the image 
% for ex,  riker-lace.jpg

clear x y z a ao ae

iimage=input('Enter name of image: ','s')
a=imread(iimage,'jpg');

%a=imread('riker-lace.jpg' ,'jpg');
%a=imread('finn1' ,'jpg');
%a=imread('inthead' ,'jpg');
%a=imread('car.jpg' ,'jpg');
%a=imread('cart.jpg' ,'jpg');


% Extracting the two fields

[x,y,z]=size(a);
ao=a(1:2:x,:,:); %     Odd field
ae=a(2:2:x,:,:); %     Even field

% Display the original and the two fields

figure;imshow(a);
figure;imshow(ao);
figure;imshow(ae);


% DFT of the the original and of the two fields:

clear F FO Fe F_mag Fo_mag Fe_mag F_mag2 Fo_mag2 Fe_mag2

F = fftshift(fft2(a)); Fo = fftshift(fft2(ao)); Fe = fftshift(fft2(ae));

F_mag = 20*log(1+abs(F)); Fo_mag = 20*log(1+abs(Fo)); Fe_mag = 20*log(1+abs(Fe));

F_mag2 = mat2gray(F_mag); Fo_mag2 = mat2gray(Fo_mag); Fe_mag2 = mat2gray(Fe_mag);

% Display the Fourier Transforms

figure, imshow(F_mag2,256); 
figure, imshow(Fo_mag2,256); 
figure, imshow(Fe_mag2,256);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Information on deinterlacing:


%http://nickyguides.digital-digest.com/interlace.htm
%http://www.lukesvideo.com/interlacing.html
%http://www.puremotion.com/editstudio/manual/videoediting/whatisdeinterlacing/


