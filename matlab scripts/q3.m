function k = calculateCoolingConstant(T_1, T_s, T_0, t1)
    ratio = (T_1 - T_s) / (T_0 - T_s);
    k = -log(ratio) / t1;
    fprintf('Cooling constant k = %.4f per hour\n', k);
end

function t_death = calculateTimeSinceDeath(T_1,T_s,T_normal,k)
    ratio = (T_1 - T_s) / (T_normal - T_s);
    t_death = -log(ratio) / k;
    fprintf('Time since death = %.2f hours\n', t_death);
end

T_normal = input('Enter the normal body temperature in C (usually 36.6C): ');
T_s = input('Enter the surrounding temperature (T_s) in C (roomytemp is avg 20.5C): ');
T_0 = input('You have seen the body, enter the body temperature (T_0) in C: ');
time_arrival = input('Enter the time of body discovery (in decimal hours, e.g., 21.3 for 9:18 PM): ');
T_1 = input('Enter the temperature some set time after the discovery (T_1) in C: ');
t1 = input('Enter the time interval (in hours) between T_0 and T_1: ');
disp('------------------------------------------------------------');
disp('Newton''s Law of Cooling formula:');
disp('T(t) = T_s + (T_0 - T_s) * exp(-k * t)');
disp('------------------------------------------------------------');
fprintf('Initial body temperature (T_0): %.1fC\n', T_0);
fprintf('Observed temperature (T_1) after %.1f hour(s): %.1fC\n', t1, T_1);
fprintf('Surrounding temperature (T_s): %.1fC\n', T_s);
disp('------------------------------------------------------------');
k = calculateCoolingConstant(T_1, T_s, T_0, t1);
t_death = calculateTimeSinceDeath(T_1,T_s,T_normal, k);
disp('------------------------------------------------------------');
time_of_death = time_arrival - t_death;
hours = floor(time_of_death);
minutes = (time_of_death - hours) * 60;
fprintf('Estimated time of death: %02d:%02d\n', mod(hours, 24), round(minutes));