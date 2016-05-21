function tempTable()
% print headings and initial conditions

C= zeros(1,10);
fprintf('%11s %10s %9s\n','Celsius','Fahrenheit','Kelvin')
% print each row of the table
for C= -50:10:50;
fprintf('%10.2f %10.2f %10.2f\n',C,9/5*C+32,C+273.15)
end