% ELEC 483

% demo_cif.m

% Opening a .cif file, reading the first kk frames,
% displaying kk frames as a movie and
% storing the kk frames as kk images
 
% Enter the name of the video sequence 
% for ex, CARTOON.cif

clear y u v uu vv yy yc M 

cvideo=input('Enter name of video sequence: ','s')

kk=input('Enter the number of frames: ')

% The total number of frames in the file can be obtained from
% (size of file)/(resolution of Y + 2*resolution of chrominance)
% Resolution of Y = 352*288
% Resolution of Cb, Cr = 176*144

% for example

% fpin=fopen('CARTOON.cif','rb');
% Number of frames = 17791488/(1.5*352*288)

% fpin=fopen('mobile.cif','rb'); 
% Number of frames = 45619200/(1.5*352*288)

fpin=fopen(cvideo,'rb');

map=0;

%   Read the first kk frames  

for k=1:kk 

%  Luminance frame
   
   [y]=fread(fpin,[352,288],'uchar');

%  2 subsampled chrominance frames

   [u]=fread(fpin,[176,144],'uchar');
   [v]=fread(fpin,[176,144],'uchar');
   y=y'; u=u'; v=v';

%  Create a string with a name for that frame

   str = num2str(k)
   ystr=strcat('frame-',str,'.tif');

%  Upsample the 2 chrominance frames to be able
%  to display in MATLAB

   for i=1:144,
      for j=1:176,  
         uu(i*2-1:i*2,j*2-1:j*2)=u(i,j);
         vv(i*2-1:i*2,j*2-1:j*2)=v(i,j);
      end 
   end   

   yy(:,:,1)=y; yy(:,:,2)=uu; yy(:,:,3)=vv;

%  Transform YCbCr in RGB

   yc=ycbcr2rgb(uint8(yy));

%  Write the frame in a file as image

%   imwrite(uint8(yc),ystr);

%  Create a matrix to display as movie

   M(k)=im2frame(uint8(yc));
end

fclose(fpin)
movie(M,5);
