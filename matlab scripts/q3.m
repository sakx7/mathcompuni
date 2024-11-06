% Function to calculate cooling constant
function k=calculateCoolingConstant(T_1,T_s,T_0,t1)
    k=-log((T_1-T_s)/(T_0-T_s))/t1;
    fprintf('Cooling constant k=%.4f per hour\n',k);
end

% Function to calculate time since death
function t_death=calculateTimeSinceDeath(T_1,T_s,T_normal,k)
    t_death=-log((T_1-T_s)/(T_normal-T_s))/k;
    fprintf('Time since death=%.2f hours\n',t_death);
end

% User input section
T_normal=input('Enter the normal body temperature in degrees (usually 36.6 degrees): ');
T_s=input('Enter the surrounding temperature (T_s) in degrees (roomytemp is avg 20.5 degrees): ');
T_0=input('You have seen the body, enter the body temperature (T_0) in degrees: ');
time_arrival=input('Enter the time of body discovery (in decimal hours, e.g., 21.3 for 9:18 PM): ');
T_1=input('Enter the temperature some set time after the discovery (T_1) in degrees: ');
t1=input('Enter the time interval (in hours) between T_0 and T_1: ');

% Display formula and input values
disp('------------------------------------------------------------');
disp('Newton''s Law of Cooling formula:');
disp('T(t)=T_s+(T_0-T_s)*exp(-k*t)');
disp('------------------------------------------------------------');
fprintf('Initial body temperature (T_0): %.1fC\n',T_0);
fprintf('Observed temperature (T_1) after %.1f hour(s): %.1fC\n',t1,T_1);
fprintf('Surrounding temperature (T_s): %.1fC\n',T_s);
disp('------------------------------------------------------------');

% Calculate cooling constant and time since death
k=calculateCoolingConstant(T_1,T_s,T_0,t1);
t_death=calculateTimeSinceDeath(T_1,T_s,T_normal,k);
disp('------------------------------------------------------------');

% Calculate and display estimated time of death
time_of_death=time_arrival-t_death;
hours=floor(time_of_death);
minutes=(time_of_death-hours)*60;
fprintf('Estimated time of death: %02d:%02d\n',mod(hours,24),round(minutes))