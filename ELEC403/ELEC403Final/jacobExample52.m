function j = jacobExample52(x)
x1 = x(1);
x2 = x(2);

j11 = 2*x1+1;
j12 = -2*x2 - 3;
j21 = 3*x1^2;
j22 = -4*x2^3;
j32 = 2*x1 + 2;
j33 = 3*x2^2 - 1;

j = [j11 j12; ...
    j21 j22; ...
    j32 j33];