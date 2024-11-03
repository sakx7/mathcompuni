% Input data
F = [0, 13.031, 21.485, 31.3963, 34.727, 37.119, 37.960, 39.550, 40.758, 40.986, 41.076, 41.255, 41.481, 41.564];
L = [25.400, 25.474, 25.515, 25.575, 25.615, 25.693, 25.752, 25.978, 26.419, 26.502, 26.600, 26.728, 27.130, 27.441];
% Initial parameters
L0 = 25; % mm
r = 6.4/1000; % m (convert mm to m)
A0 = pi*r^2; % m^2
% Calculate engineering stress and strain
eng_strain = (L-L0)/L0;
eng_stress = F/A0 /1e6; % Convert N/m^2 to MPa
% Calculate true stress and strain
true_strain = log(L/L0);
true_stress = F.*L0./(A0*L)/1e6; % Convert N/m^2 to MPa
% Plot the curves
figure;
plot(eng_strain, eng_stress, 'b-');
hold on;
plot(true_strain, true_stress, 'r--');
xlabel('Strain');
ylabel('Stress (MPa)');
title('Engineering vs True Stress-Strain Curves');
legend('Engineering', 'True');
grid on;
hold off;