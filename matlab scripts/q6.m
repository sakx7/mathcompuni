% Function to calculate pressure using the Ideal Gas Law
function P1 = idealgas(n, R, T, V)
    P1 = n * R * T / V;
end

% Function to calculate pressure using the Van der Waals equation
function P2 = van(n, R, T, V, a, b)
    P2 = n * R * T / (V - n * b) - n^2 * a / V^2;
end

% Function to calculate the percentage error between pressures
function error_percent = percent_error(P1, P2)
    error_percent = abs((P2 - P1) / P2) * 100;
end

% Nitrogen properties
a = 1.39;
b = 0.0391;
n = 1;
T = 300;
R = 0.08206;

% Define volume range and initialize arrays
Vol = 0.1:0.02:1;
P1 = zeros(size(Vol));
P2 = zeros(size(Vol));
error_vals = zeros(size(Vol));

% Calculate pressures and errors for each volume
for i = 1:length(Vol)
    V = Vol(i);
    P1(i) = idealgas(n, R, T, V);
    P2(i) = van(n, R, T, V, a, b);
    error_vals(i) = percent_error(P1(i), P2(i));
    fprintf('Vol: %.2f [P1: %.4f, P2: %.4f, Error: %.2f%%]\n', Vol(i), P1(i), P2(i), error_vals(i));
end

% Find maximum error and corresponding volume
[max_error, idx] = max(error_vals);
V_max_error = Vol(idx);
fprintf('Maximum Error: %.2f%% at Volume: %.2f\n', max_error, V_max_error);

% Plot pressures vs volume
figure;
plot(Vol, P1, 'b-', 'LineWidth', 2, 'DisplayName', 'Ideal Gas Law');
hold on;
plot(Vol, P2, 'r-', 'LineWidth', 2, 'DisplayName', 'Van der Waals');
plot(Vol, P1, 'bx','LineWidth', 2, 'Markersize', 4);
plot(Vol, P2, 'rx','LineWidth', 2, 'Markersize', 4);

% Set labels, title, and legend
xlabel('Volume (V)');
ylabel('Pressure (Pa)');
title('Pressure vs Volume for Ideal Gas and Van der Waals Gas');
legend('Ideal Gas Law', 'Van der Waals', 'Location', 'best');
grid on;

% Apply consistent axis formatting
ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickDir = 'out';
ax.FontName = 'Calibri';
ax.FontSize = 12;

% Set y-axis limits based on max pressure for scaling
ylim([0, max(max(P1), max(P2)) * 1.1]);

% Save the final plot as a PNG file
print('-dpng', '-r300', 'Pressurevolume.png');
hold off;
