function Vab = calculate_Wheatstone(V, R1, R2, R3, R4)
    Vab = V * (R1 * R3 - R2 * R4) / ((R1 + R2) * (R3 + R4));
end



fprintf('The formula for voltage Vab in the Wheatstone Bridge is:\n');
fprintf('Vab = V * (R1 * R3 - R2 * R4) / ((R1 + R2) * (R3 + R4))\n');
disp('--------------------------------------------------------------------');


function confirm = confirmValue(type)
    while true
        sure = upper(input(sprintf('Are you sure a %s is what you want? (Y/N): ', type), 's'));
        if strcmp(sure, 'Y')
            confirm = true;
            return;
        elseif strcmp(sure, 'N')
            fprintf('Returning to previous input...\n');
            confirm = false;
            return;
        else
            fprintf('Invalid input. Please enter either Y or N.\n');
        end
    end
end


while true
    userInput = input('Enter the value of V (voltage in volts): ', 's'); 
    V = str2double(userInput);
    if isnan(V)
        fprintf('ERROR: Input must be a numeric value.\n');
        continue;
    end
    if V>0
        break;
    elseif V==0
        fprintf('ISSUE: V cannot equal 0\n')
    else
        fprintf('ISSUE: A negative voltage isn''t realistic.\n');
        if confirmValue('negative value')
            break;
        end
    end
end


function [R1, R2, R3, R4] = promptForResistors()
    function R = getResistor(name, comparisonValue)
        disp('--------------------------------------------------------------------');
        while true
            userInput = input(sprintf('Enter the value of %s (in ohms): ', name), 's');

            R = str2double(userInput);
            if isnan(R) 
                fprintf('ERROR: Input must be a numeric value.\n');
                continue;
            end

            issues = cell(0);

            if R < 0
                issues{end+1} = 'ISSUE: A negative resistor isn''t realistic.';
            end
            if R == 0
                issues{end+1} = 'ISSUE: A resistor of zero isn''t realistic.';
            end
            if nargin > 1 && R == -comparisonValue
                issues{end+1} = sprintf('ISSUE: %s cannot be equal and opposite to %s.', name, inputname(2));
                if R < 0 || R==0
                    issues = issues(end);
                end
            end
            
            if ~isempty(issues)
                fprintf('%s\n', strjoin(issues, '\n'));
                if any(contains(issues, 'cannot be equal and opposite to'))
                    fprintf('Please enter a different value.\n');
                    continue;
                elseif any(contains(issues, 'zero'))
                    if ~confirmValue('value of zero')
                        continue;
                    end
                elseif ~confirmValue('negative value')
                   continue;
                end
            end
            break;

        end
    end
    R1 = getResistor('R1');
    R2 = getResistor('R2', R1);
    R3 = getResistor('R3');
    R4 = getResistor('R4', R3);
end

[R1, R2, R3, R4] = promptForResistors();
fprintf('\nVoltage value : V = %.2f\n', V);
fprintf('Resistor values: R1 = %.2f, R2 = %.2f, R3 = %.2f, R4 = %.2f\n', R1, R2, R3, R4);
Vab = calculate_Wheatstone(V, R1, R2, R3, R4);
fprintf('The calculated voltage V_ab across the Wheatstone Bridge is: %.2f volts\n', Vab);

