% Define constants
v_A = 320; % speed of aircraft A in mi/hr
v_B = 160; % speed of aircraft B in mi/hr
x0 = 400; % initial x-distance between aircraft in mi
y0 = 300; % initial y-distance between aircraft in mi

% Define time range (in hours)
t = 0:0.01:2;

% Calculate distance as a function of time
D = sqrt((x0 - v_A*t).^2 + (y0 - v_B*t).^2);

% Find minimum distance and time of minimum
[min_D, min_index] = min(D);
t_min = t(min_index);

% Plot D versus time
figure('Position', [100, 100, 800, 600])
plot(t, D, 'LineWidth', 2)
hold on
plot(t_min, min_D, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
xlabel('Time (hours)', 'FontSize', 14)
ylabel('Distance between aircraft (mi)', 'FontSize', 14)
title('Distance between Aircraft vs Time', 'FontSize', 16)
grid on
axis([0 t_min+0.5 0 max(D)+50])

% Add annotation for minimum point
text(t_min+0.05, min_D, sprintf('Minimum: (%.2f, %.2f)', t_min, min_D), ...
    'FontSize', 12, 'VerticalAlignment', 'bottom')

% Enhance plot appearance
set(gca, 'FontSize', 12)
box on

% Find time when aircraft are first within 30 mi of each other
coeff = [v_A^2 + v_B^2, -2*(v_A*x0 + v_B*y0), x0^2 + y0^2 - 30^2];
t_30 = min(roots(coeff));

% Add this information to the plot
plot(t_30, sqrt((x0 - v_A*t_30)^2 + (y0 - v_B*t_30)^2), 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g')
text(t_30+0.05, sqrt((x0 - v_A*t_30)^2 + (y0 - v_B*t_30)^2), ...
    sprintf('First within 30 mi: (%.2f, %.2f)', t_30, 30), ...
    'FontSize', 12, 'VerticalAlignment', 'bottom')

% Display results
fprintf('Minimum distance: %.2f mi at t = %.2f hours\n', min_D, t_min)
fprintf('Aircraft are first within 30 mi of each other at t = %.2f hours\n', t_30)

% Save the figure as a high-quality image
print('-dpng', '-r300', 'aircraft_distance_plot.png')
