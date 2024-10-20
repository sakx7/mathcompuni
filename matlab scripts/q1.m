
%make a function to call for the calculation

% In MATLAB, when defining a function that returns a value,
% you must specify an output argument in the function declaration
% and assign the result to this output argument,
% rather than using return %

function L_ABC = calculate_arc_length(a, b)
    %write in ascci math using matlab built in functions
    L_ABC = (1/2) * sqrt(b^2 + 16 * a^2) + (b^2 / (8 * a)) * log((4 * a + sqrt(b^2 + 16 * a^2)) / b);
end

%prompt the user for input values
a = input('Enter the value of a (height in cm): ');
b = input('Enter the value of b (width in cm): ');

%calculate the arc length by calling the function
L_ABC = calculate_arc_length(a, b);

%display the result by printing
fprintf('The arc length L_ABC is: %.2f\n', L_ABC);

%realistically not much error handling is inputed but i dont think that is the gaol here