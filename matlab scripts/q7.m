% Define the running and swimming speeds, and distances
v_run = 3;
v_swim = 1;
L = 48;
d_s = 30;

% Define the range of y values
y_values = 0:0.0001:L;

% Calculate the total time for each y value
total_time = zeros(size(y_values));

for i = 1:length(y_values)
    y = y_values(i);
    C_s = sqrt(y^2+d_s^2);
    C_w = sqrt(d_s^2+(L-y)^2);
    t_run = C_s/v_run;
    t_swim = C_w/v_swim;
    total_time(i) = t_run+t_swim;
end

% Find the optimal y with minimum time
[min_time, idx] = min(total_time); % Find the minimum time and its index
optimal_y = y_values(idx); % Optimal y value

% Verify the result with Snell's Law
phi = atand(optimal_y/d_s);
alpha = atand((L-optimal_y)/d_s);

% Check Snell's Law
snell_ratio = sind(phi)/sind(alpha);
expected_ratio = v_run/v_swim;

fprintf('Optimal y value: %.2f m\n', optimal_y);
fprintf('Minimum time: %.2f s\n', min_time);
fprintf('Phi: %.2f degrees\n', phi);
fprintf('Alpha: %.2f degrees\n', alpha);
fprintf('Snell ratio: %.6f\n', snell_ratio);
fprintf('Expected ratio: %.6f\n', expected_ratio);

if abs(snell_ratio-expected_ratio)<1e-4
    disp('Snell''s Law essentially is satisfied.');
else
    disp('Snell''s Law is not satisfied.');
end