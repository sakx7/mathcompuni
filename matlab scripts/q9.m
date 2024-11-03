% Define time range
t = linspace(0, 4, 1000);  % Time from 0 to 4 seconds

% Define displacement and velocity functions
x = @(t) 4.219 * (exp(-1.58*t) - exp(-6.32*t));  % Displacement function
v = @(t) 26.67 * exp(-6.32*t) - 6.67 * exp(-1.58*t);  % Velocity function

% Create figure
figure('Position', [100, 100, 800, 600]);

% Plot displacement
subplot(2,2,1)
plot(t, x(t), 'LineWidth', 2)  % Displacement plot
title('Displacement vs Time')
xlabel('Time (s)')
ylabel('Displacement (m)')
grid on

% Plot velocity
subplot(2,2,2)
plot(t, v(t), 'LineWidth', 2)  % Velocity plot
title('Velocity vs Time')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on

% Plot both displacement and velocity
subplot(2,1,2)
yyaxis left
plot(t, x(t), 'LineWidth', 2)  % Displacement on left y-axis
ylabel('Displacement (m)')
yyaxis right
plot(t, v(t), 'LineWidth', 2)  % Velocity on right y-axis
ylabel('Velocity (m/s)')
title('Displacement and Velocity vs Time')
xlabel('Time (s)')
grid on

% Adjust layout
set(gcf, 'Color', 'w');  % Set background color
set(findall(gcf,'-property','FontSize'),'FontSize', 12)  % Set font size

% Save figure as high-quality image
print('-dpng', '-r300', 'railroad_bumper_plots.png')  % Save the figure
