function [] = video_read(filename) 

%input = 'filename.mp4'

%Create a temporary working folder to store the image sequence.
mkdir frames

%Create a VideoReader to use for reading frames from the file.
Video = VideoReader(filename);

%Loop through the video, reading each frame into a width-by-height-by-3 
%array named img. Write out each image to a JPEG file with a name in the 
%form imgN.jpg, where N is the frame number.
%| img001.jpg|

%| img002.jpg|

%| ...|

%| img121.jpg|

ii = 1;

while hasFrame(Video)
   img = readFrame(Video);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile('frames',filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end

end