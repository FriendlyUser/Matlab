function [totaltime,avgMBSearch,avgMAD,avgMSE,PSNR]=HBMA(Target_Img,Anchor_Img,Img_Height,Img_Width,BlockSize,rangs,range,figureon)
%
%function [totaltime,avgMBSearch,avgMAD,avgMSE,PSNR]=HBMA(Target_Img,Anchor_Img,Img_Height,Img_Width,BlockSize,rangs,range,figureon)
%
%This function calculate block motion vectors (with integer pel accuracy), using hierarchical block matching algorithm.
%An example of main function calling this function is "MEMBA", which can be entered on the command window.
%The function also use the function "EBMA" for motion estimation of every macroblock
%
%	TargetName,AnchorName: 
%		File Names of Target Frame and Anchor Frame
%	Img_Height,Img_Width:  
%		Image Height and Width of a Frame
%  BlockSize:             
%		The size of Macro Block in Frame is BlockSize(1) by BlockSize(2)
%	rangs,range:      
%		The Search Field in Frame A is from (rangs(1),rangs(2)) to (range(1),range(2))
%  Target_Img,Anchor_Img,Predict_Img:
%		Image Matrix for Target Frame, Anchor Frame, Predicted Frame
%	ox,oy,pxx,pyy:
%		The location of Motion vector is (ox,oy), (pxx,pyy) for the direction 
%	PSNR:
%		The peak signal and noise ratio between original image and predicted image
%	L:
%		The search level
%	Author: Xiaofeng Xu, Polytechnic University  4/21/2002
%   totaltime:
%       The total time of ME algorithm execution between original and predicted images (platform depended)
%   avgMBSearch:
%        The average number of Macro Block matching stages between original and predicted images
%   avgMAD:
%       The average MAD between original and predicted images
%   avgMSE:
%       The average MSE between original and predicted images
%   Author: Evgeny Kaminsky, Ben Gurion University 12/18/2002
L=3;
%Number of MB searches;
c_MB_search=0;
%Read images from files
%fid = fopen(Target_Img,'r');
%Target_Img= fread(fid,[Img_Height,Img_Width]);
%fclose(fid);
Target_Img=double(Target_Img);

%fid = fopen(Anchor_Img,'r');
%Anchor_Img= fread(fid,[Img_Height,Img_Width]);
%fclose(fid);
Anchor_Img=double(Anchor_Img);


if (figureon)
    %Display the results
    figure;
    imshow(uint8(Target_Img));
    title('Target Image') 
end
t0 = clock;
m=1;
Factor=2.^(L-1);
%Downsample Image with different resolution
Up_Target_Img=zeros(Img_Height*2,Img_Width*2);
Up_Target_Img(1:2:Img_Height*2,1:2:Img_Width*2)=Target_Img;
Up_Target_Img(1:2:Img_Height*2-1,2:2:Img_Width*2-1)=(Target_Img(:,1:Img_Width-1)+Target_Img(:,2:Img_Width))/2;
Up_Target_Img(2:2:Img_Height*2-1,1:2:Img_Width*2-1)=(Target_Img(1:Img_Height-1,:)+Target_Img(2:Img_Height,:))/2;
Up_Target_Img(2:2:Img_Height*2-1,2:2:Img_Width*2-1)=(Target_Img(1:Img_Height-1,1:Img_Width-1)+Target_Img(1:Img_Height-1,2:Img_Width)+Target_Img(2:Img_Height,1:Img_Width-1)+Target_Img(2:Img_Height,2:Img_Width))/4;

TargetDown=zeros(3,Img_Height,Img_Width);
%AnchorDown=TargetDown;
TargetDown1=Target_Img;
AnchorDown1=Anchor_Img;

AnchorDown2(1:Img_Height/2,1:Img_Width/2)=Anchor_Img(1:2:Img_Height,1:2:Img_Width);
AnchorDown3(1:Img_Height/4,1:Img_Width/4)=AnchorDown2(1:2:Img_Height/2,1:2:Img_Width/2);

TargetDown2(1:Img_Height/2,1:Img_Width/2)=Target_Img(1:2:Img_Height,1:2:Img_Width);
TargetDown3(1:Img_Height/4,1:Img_Width/4)=TargetDown2(2:2:Img_Height/2,1:2:Img_Width/2);

Predict_Img=Target_Img;

rangs(1)=rangs(1)/Factor;
range(1)=range(1)/Factor;

rangs(2)=rangs(2)/Factor;
range(2)=range(2)/Factor;

Img_Height=Img_Height/Factor;
Img_Width=Img_Width/Factor;


%Search for all the blocks in Anchor Images of 1st level
for i=1:BlockSize(1):Img_Height-BlockSize(1)+1
   RangeStart(1)=i+rangs(1);
   RangeEnd(1)=i+BlockSize(1)-1+range(1);
   if RangeStart(1)<1
      RangeStart(1)=1;
   end   
   if RangeEnd(1)>Img_Height
      RangeEnd(1)=Img_Height;
   end
   for j=1:BlockSize(2):Img_Width-BlockSize(2)+1
      RangeStart(2)=j+rangs(2);
      RangeEnd(2)=j+BlockSize(2)-1+range(2);
	   if RangeStart(2)<1
   	   RangeStart(2)=1;
	   end   
   	if RangeEnd(2)>Img_Width
      	RangeEnd(2)=Img_Width;
      end
      tmpt(:,:)=TargetDown3(:,:);
      tmpa(:,:)=AnchorDown3(:,:);
      [px(m), py(m),MB_search]=EBMA(tmpt,tmpa,BlockSize,[i,j],RangeStart,RangeEnd);
      c_MB_search=MB_search+c_MB_search;
      ox(m)=j;
      oy(m)=i;
      m=m+1;
   end
end
if (figureon)
%Disfplay the results
    figure;
    imshow(uint8(TargetDown3));
    title('TargetDown3')
    figure;
    imshow(uint8(AnchorDown3));
    title('AnchorDown3')

    hold on
    quiver(ox,oy,px,py);

    hold off
    axis image
end
%Search for all the blocks in Anchor Images of all levels
for ii=L-1:-1:1
   %Update all parameters for the currenet level.
   px=px*2;
   py=py*2;
   Img_Height=Img_Height*2;
   line_width=floor(Img_Width/BlockSize(2));
   Img_Width=Img_Width*2;
   ttt=size(py);
   
	 m=1;
    %Search for all the blocks in Anchor Images in the iith level
    for i=1:BlockSize(1):Img_Height-BlockSize(1)+1
      
      baseline=double(uint32(i/2/BlockSize(1)))*double(line_width);
      for j=1:BlockSize(2):Img_Width-BlockSize(2)+1
         %Caculate the search range in Target Images.
         mindx=floor(baseline+double(uint32(j/2/BlockSize(2)))+1);
         if mindx>ttt(2)
            mindx=ttt(2);
         end
         
         RangeStart(1)=i+py(mindx)+rangs(1);
	   	RangeEnd(1)=i+py(mindx)+BlockSize(1)-1+range(1);
	   	if RangeStart(1)<1
   	   	RangeStart(1)=1;
	   	end   
	   	if RangeEnd(1)>Img_Height
   	   	RangeEnd(1)=Img_Height;
	   	end
         
         RangeStart(2)=j+px(mindx)+rangs(2);
	      RangeEnd(2)=j+px(mindx)+BlockSize(2)-1+range(2);         
         if RangeStart(2)<1
   		   RangeStart(2)=1;
		   end   
   		if RangeEnd(2)>Img_Width
      		RangeEnd(2)=Img_Width;
         end
         
         if ii==2
      	     tmpt=TargetDown2(:,:);
              tmpa=AnchorDown2(:,:);
              
         end 
           
         if ii==1
      	     tmpt=TargetDown1(:,:);
              tmpa=AnchorDown1(:,:);
              
          end
          
			    [pxx(m), pyy(m),MB_search, Predict_Img(i:i+BlockSize(1)-1,j:j+BlockSize(1)-1)]=EBMA(tmpt,tmpa,BlockSize,[i,j],RangeStart,RangeEnd);
                c_MB_search=MB_search+c_MB_search;
 
                  %Refine final result by half-pel accuracy search   
         if(ii==1)                  
            RangeStart(1)=(i+pyy(m))*2-1-2;
	  		 	RangeEnd(1)=(i+pyy(m))*2-1+BlockSize(1)*2-1+2;
	   		if RangeStart(1)<1
   	   		RangeStart(1)=1;
		   	end   
		   	if RangeEnd(1)>Img_Height*2
   		   	RangeEnd(1)=Img_Height*2;
	   		end
         
         	RangeStart(2)=(j+pxx(m))*2-1-2;
		      RangeEnd(2)=(j+pxx(m))*2-1+BlockSize(2)*2-1+2;         
   	      if RangeStart(2)<1
   			   RangeStart(2)=1;
		   	end   
            if RangeEnd(2)>Img_Width*2
               RangeEnd(2)=Img_Width*2;
      	   end
	  	      tmpa=AnchorDown1(:,:);
                [pxx(m), pyy(m),MB_search,Predict_Img(i:i+BlockSize(1)-1,j:j+BlockSize(1)-1)]=EBMA(Up_Target_Img,tmpa,BlockSize,[i,j],RangeStart,RangeEnd,2);
               c_MB_search=MB_search+c_MB_search;
   	  end
	     	ox(m)=j;
	      oy(m)=i;
      	m=m+1;
	  end
	end
   px=pxx;
   py=pyy;
   
end
totaltime=etime(clock,t0);
imgsize = Img_Height*Img_Width;
%Caculate error image
Error_Img=Anchor_Img-Predict_Img;
%Calculate totalerror
totalerror=sum(sum(abs(Error_Img)));
%Calculate average MAD
avgMAD=totalerror/imgsize;
%Calculate average MSE
avgMSE=mean(mean((Error_Img.^2)));
%Caculate PSNR
PSNR=10*log10(255*255/avgMSE);
%Claculate average number of searching stages for each Macro Block
MB_total=imgsize/(BlockSize(1)*BlockSize(2));
avgMBSearch = c_MB_search/MB_total;


if (figureon)
    
%Display the results
figure;
imshow(uint8(TargetDown2));
title('TargetDown2')
figure;
imshow(uint8(AnchorDown2));
%imshow(AnchorDown2);
title('AnchorDown2')
hold on
quiver(ox,oy,pxx,pyy);

hold off
pause(2);

%Display the results
figure;
imshow(uint8(Anchor_Img));
title('Anchor Image')

hold on
quiver(ox,oy,pxx,pyy);

hold off
axis image

figure;
imshow(uint8(Predict_Img));
title('Predicted Image')

figure;
imshow(uint8(Error_Img));
title('Error Image')
end
