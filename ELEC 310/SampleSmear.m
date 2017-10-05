% Load the image for smearing
[X,m] = imread('moon.jpg');

% Alpha (clocking time as portion of initial exposure time.)
alpha = 0.01;

% Obtain the size of the image.
[rows,cols] = size(X);

% Create the simulated CCD array.
% Columns 1:cols are the exposed CCD array
% Columns cols+1:2*cols are the storage CCD array
image_buffer = zeros( rows , 2 * cols );

% Initial image exposure
image_buffer( : , 1 : cols ) = double(X);

% Simulated clocking into storage CCD array
for kk=1:cols,
    
    % Clock image right
    image_buffer( : , 2 : 2 * cols ) = image_buffer( : , 1 : 2 * cols - 1 );
    
    % Add exposure
    image_buffer( : , 1: cols ) = image_buffer( : , 1 : cols ) + ...
        alpha * double(X); 
end

% Retrieve smeared image from storage array.
smear_image = image_buffer( : , cols + 1 : 2 * cols );

% Display the smeared image.
imagesc(smear_image);
axis equal;
colormap('gray');
