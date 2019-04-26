% Embedded an transparent watermark into a image (video frame)
% input:     wmPath   -- transparent watermarked image, can be logo or text
%            frame    -- (background image/ video frame) that will get watermarked, should be larger than the watermark
%            rowShift -- number of horizontal pixels to shift the watermark by (default = 0)
%            colShift -- number of vertical pixels to shift the watermark by (default = 0)
%            saveName -- file name of the saved watermarked image
% output:    framewm -- visibly watermarked image
%            occulsion -- image with white background containing watermark
%
% Ref: https://www.mathworks.com/matlabcentral/answers/100086-how-do-i-superimpose-images-in-matlab, remove later
% By David Li and Solitei Tutui
function  [framewm, occulsion] = VWM(wmPath, frame, alpha, rowShift, colShift, saveName)

    % Some function with 2 required inputs, 3 optional.
    
    % Check number of inputs.
    if nargin > 6
        error('VWM:TooManyInputs', ...
            'requires at most 3 optional inputs');
    end
    
    % Fill in unset optional values.
    switch nargin
        case 2
            alpha = 0.2
            rowShift = 0;
            colShift = 0;
            saveName = 'testImg.png';
        case 3
            rowShift = 0;
            colShift = 0;
            saveName = 'testImg.png';
        case 4
            colShift = 0;
            saveName = 'testImg.png';
        case 5
            saveName = 'testImg.png';
    end
    
    % Read image data and alpha from transparent image
    [wm, ~, ImageAlpha] = imread(wmPath);
    
    % Now replace pixels in the frame with the watermark image
    framewm = frame;
    
    % watermark grayscale image dimensions
    wmx = size(wm,1);
    wmy = size(wm,2);
    % frame grayscale image dimensions
    framex = size(frame,1);
    framey = size(frame,2);

    % Ensure that frame is bigger than watermark
    if framex <= wmx | framey <= wmy
       error('VWM:DimToLarge', ...
          'watermark should be smaller than frame');
    end 
    
    occulsion = zeros(framex,framey, 3);
    occulsion( 1+rowShift:wmx + rowShift, 1+colShift:wmy + colShift, :) = wm;

    % OPTIONAL --- Ensure that watermark is transparent, MAY BE UNEEDED
    % Check if watermark is transparent
    if isempty(ImageAlpha)
        framewm(1:wmx + rowShift,1:wmy + colShift, :) = wm;
    else
        % Appending non tranparent watermark pixels to frame
        for i = 1:1:wmx
            for j= 1:1:wmy
                % Check if is nontransparent pixel should be added to frame
                % https://stackoverflow.com/questions/9014729/manually-alpha-blending-an-rgba-pixel-with-an-rgb-pixel
                % Typical Overblend method
                if  ImageAlpha(i,j) > 0
                    tempfm = framewm(i+rowShift,j+colShift, :);
                    % framewm(i+rowShift,j+colShift, :) = 0.5*(wm(i,j,:) + tempfm);
                    framewm(i+rowShift,j+colShift, :) = (alpha*wm(i,j,:) + (1-alpha)*tempfm);
                end
            end
        end 
    end
    if (saveName ~= "")
        imwrite(framewm, saveName);
    end
    % title(sprintf('Using indexing to overlay images:\nresult is one image object'))
end