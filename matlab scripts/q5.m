% Constants
g = 9.81; % Acceleration due to gravity (m/s^2)
% User Inputs
u = input('Enter the initial velocity (u) in m/s: ');
theta = input('Enter the launch angle (theta) in degrees: ');
h = input('Enter the initial height (h) in meters: ');
% Convert angle from degrees to radians
theta_rad = deg2rad(theta);
% Calculate initial velocities in x and y directions
u_x = u * cos(theta_rad);
u_y = u * sin(theta_rad);
% Calculate Time of Flight (T)
T = (u_y + sqrt(u_y^2 + 2 * g * h)) / g;
% Calculate Range (R)
R = (u_x / g) * (u_y + sqrt(u_y^2 + 2 * g * h));
% Calculate maximum height (H)
H = (u_y^2 / (2 * g)) + h;
% Time vector for plotting
t = linspace(0, T, 100);
% Calculate displacements in x and y directions
s_x = u_x * t; % Displacement in x
s_y = (u_y * t) - (0.5 * g * t.^2) + h; % Displacement in y
% Calculate radial distance r(t) and angle theta(t)
r = sqrt(s_x.^2 + s_y.^2);
theta_t = atan2(s_y, s_x); % Angle in radians
% Find the maximum r(t)
max_r = max(r);
max_r_index = find(r == max_r, 1);
max_time_r = t(max_r_index);
% Find the maximum theta(t)
max_theta = max(theta_t);
max_theta_index = find(theta_t == max_theta, 1);
max_time_theta = t(max_theta_index);
% Calculate velocity at time T
v_x_T = u_x; % Constant velocity in x
v_y_T = sqrt(u_y^2 + 2 * g * h); % Velocity in y at time T
v_T = sqrt(v_x_T^2 + v_y_T^2); % Total velocity at time T
% Display results
fprintf('Time of Flight (T): %.2f seconds (time until projectile hits the ground)\n', T);
fprintf('Range (R): %.2f meters (horizontal distance covered)\n', R);
fprintf('Max Height (H): %.2f meters (peak vertical height above the ground)\n', H);
fprintf('Velocity at separation (v(T)): %.2f m/s (Note: This simulation assumes negligible air resistance.)\n', v_T);
fprintf('Maximum radial distance (r(t)): %.2f meters at t = %.2f seconds\n', max_r, max_time_r);

max_theta_deg = max_theta * 180 / pi;  % Convert to degrees for clarity
fprintf('Maximum angle (theta(t)): %.2f degrees at t = %.2f seconds\n', max_theta_deg, max_time_theta);

% Create a single figure with three subplots
figure('Position', [100, 100, 800, 600]);
% Plot the trajectory in Cartesian coordinates (top subplot)
subplot(2,1,1);
plot(s_x, s_y);
title('Projectile Motion Trajectory');
xlabel('Displacement in X (m)');
ylabel('Displacement in Y (m)');
grid on;
hold on;
plot(u_x*u_y/g, H, 'x', 'MarkerSize', 10, 'LineWidth', 2,'Color', [0.059, 0.125, 1], 'DisplayName', 'Max Height');
legend('Trajectory', 'Max Height', 'Location', 'best');
hold off;
% Plot r(t) (bottom-left subplot)
subplot(2,2,3);
plot(t, r, 'Color', [0, 0.85, 0], 'DisplayName', 'r(t)'); % Darker green
hold on;
plot(max_time_r, max_r, 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', [0, 0.85, 0], 'DisplayName', 'Max r(t)');
xlabel('Time (s)');
ylabel('Radial Distance (m)');
title('Radial Distance r(t)');
grid on;
legend('Location', 'best');
hold off;
% Plot theta(t) (bottom-right subplot)
subplot(2,2,4);
plot(t, rad2deg(theta_t), 'r-', 'DisplayName', 'theta(t)');
hold on;
plot(max_time_theta, rad2deg(max_theta), 'x', 'MarkerSize', 10, 'LineWidth', 2,'Color', 'r', 'DisplayName', 'Max theta(t)');
xlabel('Time (s)');
ylabel('Angle theta(t) (degrees)');
title('Angle theta(t)');
grid on;
legend('Location', 'best');
hold off;
% Adjust the layout
sgtitle('Projectile Motion Analysis');