function MEBMA(start_frame,end_frame,algorithm,movie,distance,Img_Height,Img_Width,Block,rangs,range,figureon,K,debug)
%function MEBMA(start_frame,end_frame,algorithm,movie,distance,Img_Height,Img_Width,Block,rangs,range,figureon,K,debug)
%
%MEBMA (Motion Estimation (ME) Block Matching algorithm) compute various complexity and distortion parameters for 
%given movie (.mat format) in either HBMA (multy resolution) or EBMA (full search) Block Matching algorithms
%The function produce output file (.mat format) with C/D parameters for each given movie
%!!!The function also use the function "HBMA" and "Motion_Estimation_2D" for ME between original and predicted images
%   start_frame, end_frame:
%       Start frame and end frame of given movie
%   algorithm:
%       Block matching motion estimation algorithm (MEBMA)
%   movie:
%       Given movie (.mat format)
%   distance:
%       The distance criterium for given MEBMA algorithm
%	Img_Height,Img_Width:  
%		Image Height and Width of a Frame
%   Block:             
%		The size of Macro Block in Frame is Block by Block
%	rangs, range:      
%		The Search Field in Frame A is from (rangs(1),rangs(2)) to (range(1),range(2))
%	K:
%		The search accuracy: 1 integer pel 2 half pel
%   Target_Img,Anchor_Img:
%		Image Matrix for Target Frame, Anchor Frame
%	PSNR
%		The peak signal and noise ratio between original image and predicted image
%   totaltime:
%       The total time of ME algorithm execution between original and predicted images (platform depended)
%   avgMBSearch:
%        The average number of Macro Block matching stages between original and predicted images
%   avgMAD:
%       The average MAD between original and predicted images
%   avgMSE:
%       The average MSE between original and predicted images
%   MBsearch:
%       The number of search stages for each Macro Block (for debug mode only)     
%   debug:
%       The debug mode (if debug==1 the MAD and the MB_search matrices were printed)
%   figureon:
%       The figureon mode (if figureon==1 the various figures were printed)
%   Author: Evgeny Kaminsky, Ben Gurion University 12/18/2002
total_frames=end_frame-start_frame;
totaltime=zeros(1,total_frames);
avgMBSearch=zeros(1,total_frames);
avgMAD=zeros(1,total_frames);
avgMSE=zeros(1,total_frames);
PSNR=zeros(1,total_frames);
for i=1:total_frames,
    %Target_Img=sprintf('%s%d.Y',movie,start_frame+i-1);
    load(movie);
     Target_Img=video{start_frame+i-1};
     
    %Anchor_Img=sprintf('%s%d.Y',movie,start_frame+i);
    Anchor_Img=video{start_frame+i};
     switch algorithm
         case 'EBMA'
            [totaltime(i),avgMBSearch(i),avgMAD(i),avgMSE(i),PSNR(i)]=Motion_Estimation_2D(algorithm,Target_Img,Anchor_Img,Img_Height,Img_Width,[Block Block],rangs,range,K,figureon,debug);
         case 'HBMA'
            [totaltime(i),avgMBSearch(i),avgMAD(i),avgMSE(i),PSNR(i)]=HBMA(Target_Img,Anchor_Img,Img_Height,Img_Width,[Block Block],rangs,range,figureon);
         %case 'newMEalgorithm'
            %[totaltime(i),avgMBSearch(i),avgMAD(i),avgMSE(i),PSNR(i)]=Motion_Estimation_2D(algorithm,Target_Img,Anchor_Img,Img_Height,Img_Width,[Block Block],rangs,range,K,figureon,debug);
     end
end
clear video
file=sprintf('%s_%s_%s_%d_%d',algorithm,movie,distance,Block,range(1));
save(file,'totaltime','avgMBSearch','avgMAD','avgMSE','PSNR')
