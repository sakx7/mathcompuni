function L_ABC = l_abc(a, b)
    L_ABC = ((1/2) * sqrt(b^2 + 16 * a^2) + (b^2 / (8 * a)) * log((4 * a + sqrt(b^2 + 16 * a^2)) / b));
end
fprintf('The formula for arc length L_ABC is:\n');
fprintf('L_ABC = (1/2) * sqrt(b^2 + 16 * a^2) + (b^2 / (8 * a)) * log((4 * a + sqrt(b^2 + 16 * a^2)) / b)\n\n');
while true
    a = input('Enter the value of a (height in cm): ');
    if a ~= 0
        while true
            b = input('Enter the value of b (width in cm): ');
            if b > 0
                break;
            else
                fprintf('b must be a greater than zero. Please try again.\n');
            end
        end
        break;
    else
        fprintf('a must be a non-zero value. Please try again.\n');
    end
end
L_ABC = l_abc(a, b);
fprintf('The arc length L_ABC is: %.2f\n', L_ABC);
