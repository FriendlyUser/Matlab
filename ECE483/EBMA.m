function [mv_x, mv_y,MB_search,predict_img,error]=EBMA(Target_Img,Anchor_Img,BlockSize,BlockLocation,RangeStart,RangeEnd,accuracy)
%
%function [mv_x, mv_y,MB_search,predict_img]=EBMA(Target_Img,Anchor_Img,BlockSize,BlockLocation,RangeStart,RangeEnd,accuracy)
%
%EBMA compute Motion Vector for one block in Anchor Frame from Target Frame
%This function is called by function Motion_Estimation_2D() and HBMA().
%
%	Target_Img,Anchor_Img: 
%		Image Matrixs of Target Frame and Anchor Frame
%	BlockSize:             
%		The size of Macro Block is BlockSize(1) by BlockSize(2)
%	BlcokLocation:
%		The Macro Block Location in Anchor Frame 
%	RangeStart,RangeEnd:      
%		The Search Field in Frame A is from (RangeStart(1),RangeStart(2)) to (RangeEnd(1),RangeEnd(2))
%  Target_Img,Anchor_Img,Predict_Img:
%		Image Matrix for Target Frame, Anchor Frame, Predicted Frame
%	accuracy:
%		Calculation Accuracy: 1 for integer pel; 2 for half pel
%	mv_x,mv_y:
%		The direction of Motion vector is (mv_x,mv_y)
%	predict_img:
%		The best estimation block for given block
%	Author: Xiaofeng Xu, Polytechnic University  4/21/2002
%   error:
%       The minimal SAD for given block 
%   MB_search:
%       The number of searching stages for given block
%   Author: Evgeny Kaminsky Ben Gurion University 12/18/2002

%Set default caculation accuracy 
if nargin<7
   accuracy=1; 
end 
%Initial MB_search
MB_search=0;
ty=BlockLocation(1);
tx=BlockLocation(2);
Ny=BlockSize(1);
Nx=BlockSize(2);
%Get the anchor macro block
AnchorBlock=Anchor_Img(ty:ty+Ny-1,tx:tx+Nx-1);

%Initial mv_x mv_y
mv_x=0;
mv_y=0;

%Initial error
error=255*Nx*Ny*100;

%Search the best estimation from (RangeStart(1),RangeStart(2)) to (RangeEnd(1),RangeEnd(2))
 for y=RangeStart(1):RangeEnd(1)-accuracy*Ny+1
   for x=RangeStart(2):RangeEnd(2)-accuracy*Nx+1
      down_Target_Img=Target_Img(y:accuracy:y+accuracy*Ny-1,x:accuracy:x+accuracy*Nx-1);
      %caculate the error
      temp_error=sum(sum(abs(AnchorBlock-down_Target_Img)));
        MB_search=MB_search+1; 
		if temp_error < error
		 error=temp_error;
         mv_x=x/accuracy-tx;
         mv_y=y/accuracy-ty;
         predict_img=down_Target_Img;
		end;
	end;
end;
