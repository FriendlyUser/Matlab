function [] = video_write()

%Create a temporary working folder to store the image sequence.
mkdir video_out

%Find all the JPEG file names in the images folder. 
%Convert the set of image names to a cell array.

imageNames = dir(fullfile('frames','*.jpg'));
imageNames = {imageNames.name}';

%Construct a VideoWriter object, which creates a Motion-JPEG AVI 
%file by default.

outputVideo = VideoWriter(fullfile('video_out','video_out.avi'));
open(outputVideo)

%Loop through the image sequence, load each image, and then 
%write it to the video.

for ii = 1:length(imageNames)
   % apply watermarking
   img = imread(fullfile('frames',imageNames{ii}));
   [framewm, garbage ] = VWM('resources/transparent.png', img, 0.25, 400,400, 'testing.png');
   writeVideo(outputVideo,framewm)
end

%Finalize the video file.

close(outputVideo)

end