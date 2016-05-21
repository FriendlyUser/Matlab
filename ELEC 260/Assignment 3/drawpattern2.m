function drawpattern2(n,the)

% degrees to radians
t = the * pi / 180;
% Generate the list of points.
p = [0 0]';
x = p';
for i = 1 : (n - 1)
    p = p + [cos(t) sin(t); -sin(t) cos(t)] ^ (i - 1) * [i 0]';
    x = [x; p'];
end
% Plot points
plot(x(:, 1), x(:, 2));
axis('equal');

