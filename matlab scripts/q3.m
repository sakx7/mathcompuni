function original = originalform(T_s, T_0)
    original = sprintf('T(t) = %.1f + (%.1f - %.1f) * exp(-k * t)', T_s, T_0, T_s);
end

function k = calculateCoolingConstant(T_1, T_s, T_0, t1)
    ratio = (T_1 - T_s) / (T_0 - T_s);
    k = -log(ratio) / t1;
    fprintf('\nCalculating cooling constant k:\n');
    fprintf('T(%.0f) = %.1f = %.1f + (%.1f - %.1f) * exp(-k * %.0f)\n', t1, T_1, T_s, T_0, T_s, t1);
    fprintf('Cooling constant k = %.4f per hour\n', k);
end

function t_death = calculateTimeSinceDeath(T_initial, T_s, T_normal, k)
    ratio = (T_initial - T_s) / (T_normal - T_s);
    t_death = -log(ratio) / k;
    fprintf('\nCalculating time since death:\n');
    fprintf('Now that we have k, we can use the equation to find t:\n');
    fprintf('%.1f = %.1f + (%.1f - %.1f) * exp(-%.4f * t)\n', T_initial, T_s, T_normal, T_s, k);
    fprintf('t, Time since death = %.2f hours\n', t_death);
end

% Prompt user for input values
T_s = input('Enter the surrounding temperature (T_s) in °C (room is avg 20.5°C): ');
T_0 = input('Youve seen the body, enter the body temperature he has (T_0) in °C: ');
T_1 = input('Enter the temperature some set time after the discovery (T_1) in °C: ');
t1 = input('Enter the time interval (in hours) between T_0 and T_1: ');
T_normal = input('Enter the normal body temperature in °C (usually 36.6°C): ');

disp('------------------------------------------------------------');
disp('Newton''s Law of Cooling formula:');
disp('T(t) = T_s + (T_0 - T_s) * exp(-k * t)');
disp('------------------------------------------------------------');
fprintf('Surrounding temperature (T_s): %.1f°C\n', T_s);
fprintf('Initial body temperature (T_0): %.1f°C\n', T_0);
fprintf('Observed temperature (T_1) after %.1f hour(s): %.1f°C\n', t1, T_1);
disp('------------------------------------------------------------');
disp('Derived form of Newton''s Law of Cooling for this scenario:');
disp(originalform(T_s, T_0));

% Calculate k and time since death
k = calculateCoolingConstant(T_1, T_s, T_0, t1);
disp('------------------------------------------------------------');
t_death = calculateTimeSinceDeath(T_0, T_s, T_normal, k);
disp('------------------------------------------------------------');

% Get time of body discovery
time_arrival = input('Enter the time of body discovery (in decimal hours, e.g., 21.3 for 9:18 PM): ');
time_of_death = time_arrival - t_death;
hours = floor(time_of_death);
minutes = (time_of_death - hours) * 60;

% Display final estimates
fprintf('\nEstimated cooling constant (k): %.4f per hour\n', k);
fprintf('Calculated time since death: %.2f hours\n', t_death);
fprintf('Estimated time of death: %02d:%02d\n', mod(hours, 24), round(minutes));
