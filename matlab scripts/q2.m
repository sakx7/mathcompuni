function calculate_voltage_difference()
    % request user input for voltage and resistances
    V = input('Enter the voltage V (in volts): ');
    R1 = input('Enter the resistance R1 (in ohms): ');
    R2 = input('Enter the resistance R2 (in ohms): ');
    R3 = input('Enter the resistance R3 (in ohms): ');
    R4 = input('Enter the resistance R4 (in ohms): ');
    Vab = V * (R1 * R3 - R2 * R4) / ((R1 + R2) * (R3 + R4));
    fprintf('The voltage difference V_ab between points a and b is: %.4f volts\n', Vab);
end
% test the program with given values
V_test = 14;
R1_test = 120.6;
R2_test = 119.3;
R3_test = 121.2;
R4_test = 118.8;
% calculate using the test values
Vab_test = V_test * (R1_test * R3_test - R2_test * R4_test) / ((R1_test + R2_test) * (R3_test + R4_test));
fprintf('Initial testing with values: V = %.2f V, R1 = %.2f Ohm, R2 = %.2f Ohm, R3 = %.2f Ohm, R4 = %.2f Ohm\n', ...
        V_test, R1_test, R2_test, R3_test, R4_test);
fprintf('The voltage difference V_ab (test case) is: %.4f volts\n', Vab_test);
fprintf('-------------------------------\n');
calculate_voltage_difference()