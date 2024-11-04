% Define constants
v_A = 320;
v_B = 160;
x0 = 800;
y0 = 410;

% Define time range (in hours)
t = 0:0.01:3;

D = sqrt((x0 - v_A * t).^2 + (y0 - v_B * t).^2);

[min_D, min_index] = min(D);
t_min = t(min_index);

% Plot D versus time
figure('Position', [100, 100, 800, 600])
plot(t, D, 'LineWidth', 2)
hold on

% Mark minimum distance point
plot(t_min, min_D, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r')
text(t_min + 0.05, min_D, sprintf('Minimum: (%.2f hr, %.2f mi)', t_min, min_D), ...
    'FontSize', 12, 'VerticalAlignment', 'top', 'Color', 'r')

% Add horizontal line at 30 miles
yline(30, '--', 'Color', '#7E2F8E', 'LineWidth', 1.5);
text(0, 30, '30 mi threshold', 'FontSize', 12, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left','Color', '#7E2F8E')

% Find times when the distance is exactly 30 miles
coeff = [v_A^2 + v_B^2, -2 * (v_A * x0 + v_B * y0), x0^2 + y0^2 - 30^2];

t_30_all = roots(coeff);
t_30_all = t_30_all(t_30_all > 0);
t_30_first = min(t_30_all);
t_30_second = max(t_30_all);

% Mark the points where distance is exactly 30 miles
plot([t_30_first, t_30_second], [30, 30],'o', 'MarkerSize', 6, 'MarkerFaceColor', '#7E2F8E')
text(t_30_first, 30, sprintf('%.2f hr', t_30_first), 'FontSize', 14,'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', '#7E2F8E')
text(t_30_second, 30, sprintf('%.2f hr', t_30_second), 'FontSize', 14,'VerticalAlignment', 'bottom', 'Color', '#7E2F8E')

% Set up plot labels and title
xlabel('Time (hours)', 'FontSize', 14)
ylabel('Distance between aircraft (mi)', 'FontSize', 14)
title('Distance between Aircraft vs Time', 'FontSize', 16)
grid on
axis([0 t(end) 0 max(D)+50])
set(gca, 'FontSize', 12)
box on

% Save the figure as a high-quality image
print('-dpng', '-r300', 'aircraft_distance_plot.png');

% Displaying results in console
fprintf('Minimum distance: %.2f mi at t = %.2f hours\n', min_D, t_min);
t=9+60/18
fprintf('Aircraft are first within 30 mi of each other at t = %.2f \n', t_30_first);

