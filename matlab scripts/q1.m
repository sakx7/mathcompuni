
function L_ABC = l_acb(a,b)
    L_ABC=((1/2) * sqrt(b^2 + 16 * a^2) + (b^2 / (8 * a)) * log((4 * a + sqrt(b^2 + 16 * a^2)) / b));
end
%make a function to call for the calculation
function calculate_arc_length()
    %prompt the user for input values
    a = input('Enter the value of a (height in cm): ');
    b = input('Enter the value of b (width in cm): ');
    L_ABC = l_acb(a,b);%realistically not much error handling is inputed but i dont think that is the gaol here
    fprintf('The arc length L_ABC is: %.2f\n', L_ABC);
end
a_test=11;
b_test=9;
% calculate using the test values
L_ABC_test=l_acb(a_test,b_test);
fprintf('Initial testing with values: a = %.2f cm, b = %.2f cm', ...
    a_test, b_test);
fprintf('The arc length L_ABC (test case) is: %.4f\n', L_ABC_test);
fprintf('-------------------------------\n');
%calculate the arc length by calling the function
calculate_arc_length();