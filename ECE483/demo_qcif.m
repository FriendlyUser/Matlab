% ELEC 483

% demo_qcif.m

% Opening a .qcif file, reading the first kk frames,
% displaying kk frames as a movie 

% Enter the name of the video sequence
% for ex, miss_am.qcif 

clear y u v uu vv cy crgb F 

qvideo=input('Enter name of video sequence: ','s')

kk=input('Enter the number of frames:: ')

% The total number of frames in the file can be obtained from
% (size of file)/(resolution of Y + 2*resolution of chrominance)
% Resolution of Y = 176*144
% Resolution of Cb, Cr = 88*72

% for example

fpin=fopen(qvideo,'rb');

map=0;

%   Read the first kk frames

for k=1:kk

%  Luminance frame

y=fread(fpin,[176,144],'uchar');   

%  2 subsampled chrominance frames

u=fread(fpin,[88,72],'uchar'); 
v=fread(fpin,[88,72],'uchar');   
y=y'; u=u'; v=v';   


%  Upsample the 2 chrominance frames to be able
%  to display in MATLAB

for i=1:72      
for j=1:88         
uu(i*2-1:i*2,j*2-1:j*2)=u(i,j);         
vv(i*2-1:i*2,j*2-1:j*2)=v(i,j);      
end 
end       

cy(:,:,1)= y;cy(:,:,2)= uu;cy(:,:,3)= vv;   


%  Transform YCbCr in RGB

crgb=ycbcr2rgb(uint8(cy));   

%  Create a matrix to display as movie

F(k) = im2frame(crgb,map);
end
fclose(fpin); 

movie(F,5)
