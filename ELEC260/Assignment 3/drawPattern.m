%theta must be in degrees
function drawPattern(n,theta)
    t = theta * pi / 180;
    
    %Get list of points
    p= [0 0]';
    x = p';
    for i=2:n
       p= p + [cos(t) sin(t); -sin(t) cos(t)]^ (i - 1) * [i;0];
       x = [x; p'];
    end
    %Plot
    plot(x(:, 1), x(:, 2), 'red');
    axis('equal');
    
