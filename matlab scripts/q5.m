% Constants, user inputs, and initial calculations
% Define gravity and prompt user for initial velocity, launch angle, and height.
% Convert launch angle to radians and compute initial x and y velocity components.
g = 9.81;
u = input('Enter the initial velocity (u) in m/s: ');
theta = input('Enter the launch angle (theta) in degrees: ');
h = input('Enter the initial height (h) in meters: ');
theta_rad = deg2rad(theta);
u_x = u * cos(theta_rad);
u_y = u * sin(theta_rad);

% Compute flight characteristics: time of flight, range, and maximum height
% Use motion equations to determine these parameters based on initial conditions.
T = (u_y + sqrt(u_y^2 + 2 * g * h)) / g;
R = (u_x / g) * (u_y + sqrt(u_y^2 + 2 * g * h));
H = (u_y^2 / (2 * g)) + h;

% Generate time vector and calculate displacements in x and y over time
% Determine x and y positions at each time step to represent projectile motion.
t = linspace(0, T, 100);
s_x = u_x * t;
s_y = (u_y * t) - (0.5 * g * t.^2) + h;

% Calculate radial distance and angle as functions of time
% Determine radial distance r(t) and angle theta(t) to analyze the trajectory.
r = sqrt(s_x.^2 + s_y.^2);
theta_t = atan2(s_y, s_x);

% Find maximum values for radial distance and angle, along with their time points
% Identify when r(t) and theta(t) reach their maximum values during flight.
max_r = max(r);
max_r_index = find(r == max_r, 1);
max_time_r = t(max_r_index);
max_theta = max(theta_t);
max_theta_index = find(theta_t == max_theta, 1);
max_time_theta = t(max_theta_index);

% Calculate final velocity components and magnitude at time of flight
% Use final vertical and constant horizontal velocities to compute total velocity at T.
v_x_T = u_x;
v_y_T = sqrt(u_y^2 + 2 * g * h);
v_T = sqrt(v_x_T^2 + v_y_T^2);

% Display calculated results for projectile motion analysis
fprintf('Time of Flight (T): %.2f seconds (time until projectile hits the ground)\n', T);
fprintf('Range (R): %.2f meters (horizontal distance covered)\n', R);
fprintf('Max Height (H): %.2f meters (peak vertical height above the ground)\n', H);
fprintf('Velocity at separation (v(T)): %.2f m/s (Note: This simulation assumes negligible air resistance.)\n', v_T);
fprintf('Maximum radial distance (r(t)): %.2f meters at t = %.2f seconds\n', max_r, max_time_r);

% Display maximum angle in degrees for clarity
max_theta_deg = max_theta * 180 / pi;
fprintf('Maximum angle (theta(t)): %.2f degrees at t = %.2f seconds\n', max_theta_deg, max_time_theta);

% Plot trajectory and analysis results in a single figure with three subplots
figure('Position', [100, 100, 800, 600]);

% Plot trajectory in Cartesian coordinates
subplot(2,1,1);
plot(s_x, s_y);
title('Projectile Motion Trajectory');
xlabel('Displacement in X (m)');
ylabel('Displacement in Y (m)');
grid on;
hold on;
plot(u_x*u_y/g, H, 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', [0.059, 0.125, 1], 'DisplayName', 'Max Height');
legend('Trajectory', 'Max Height', 'Location', 'best');
hold off;

% Plot radial distance over time
subplot(2,2,3);
plot(t, r, 'Color', [0, 0.85, 0], 'DisplayName', 'r(t)');
hold on;
plot(max_time_r, max_r, 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', [0, 0.85, 0], 'DisplayName', 'Max r(t)');
xlabel('Time (s)');
ylabel('Radial Distance (m)');
title('Radial Distance r(t)');
grid on;
legend('Location', 'best');
hold off;

% Plot angle theta(t) over time
subplot(2,2,4);
plot(t, rad2deg(theta_t), 'r-', 'DisplayName', 'theta(t)');
hold on;
plot(max_time_theta, rad2deg(max_theta), 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Max theta(t)');
xlabel('Time (s)');
ylabel('Angle theta(t) (degrees)');
title('Angle theta(t)');
grid on;
legend('Location', 'best');
hold off;

% Adjust overall figure layout and add title
sgtitle('Projectile Motion Analysis');

print('-dpng', '-r300', 'Projectile_Motion.png')