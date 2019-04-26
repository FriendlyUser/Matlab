
% ELEC 483

% JPEG compression 
% demo_FT.m

% Enter the name of the image 
% for example,  lena.tif, man.tif

timage=input('Enter name of image: ', 's')

clear X 

[X,map]=imread(timage); 
X=double(X);

% Set the values for the Quality factor

Qu=[100 50 25 13 5];

%  Compress, write in a file and display

for i=1:5;   
   str = int2str(i);
   tname=strcat('JPEG_C/xx','jpg',str,'.jpg');
   imwrite(uint8(X),tname,'quality',Qu(i));
   figure;imshow(tname) 
end

% display the size of the files in derectory JPEG_C
% using the Unix command ls

ls -Flag JPEG_C


