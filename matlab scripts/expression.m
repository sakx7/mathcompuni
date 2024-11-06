% Define the expressions for E1 and E2
E1 = @(a, b) (4 * a * sqrt(b^4 + 16 * a^2 * b^2) + asinh(4 * a / b) * b^3) / (8 * a * b);
E2 = @(a, b) (1/2) * sqrt(b^2 + 16 * a^2) + (b^2 / (8 * a)) * log((4 * a + sqrt(b^2 + 16 * a^2)) / b);

% Initialize a cell array to store the results
results = {};

% Loop over the range of values for a and b
for a = 1:5
    for b = 1:5
        % Calculate E1 and E2
        e1 = E1(a, b);
        e2 = E2(a, b);        
        % Calculate the difference
        difference = e1 - e2;
        % Set a threshold for small differences and treat them as 0
        if abs(difference) < 1e-10
            difference = 0.0;
        end
        % Append the results to the cell array
        results = [results; {a, b, e1, e2, difference}];
    end
end

% Convert the results into a table
T = cell2table(results, 'VariableNames', {'a', 'b', 'L', 'L_ABC', 'Difference'});

% Display the table
disp(T);
