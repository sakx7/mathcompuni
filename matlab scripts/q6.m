function P1 = idealgas(n, R, T, V)
    P1 = n * R * T / V;
end

function P2 = van(n, R, T, V, a, b)
    P2 = n * R * T / (V - n * b) - n^2 * a / V^2;
end

function error_percent = percent_error(P1, P2)
    error_percent = abs((P2 - P1) / P2) * 100;
end

% Nitrogen properties
a = 1.39;
b = 0.0391;
n = 1;
T = 300;
R = 0.08206;

% Volume range
Vol = 0.1:0.02:1;
P1 = zeros(size(Vol));
P2 = zeros(size(Vol));
error_vals = zeros(size(Vol));

for i = 1:length(Vol)
    V = Vol(i);
    P1(i) = idealgas(n, R, T, V);
    P2(i) = van(n, R, T, V, a, b);
    error_vals(i) = percent_error(P1(i), P2(i));

    fprintf('Vol: %.2f [P1: %.4f, P2: %.4f, Error: %.2f%%]\n', Vol(i), P1(i), P2(i), error_vals(i));
end

[max_error, idx] = max(error_vals);
V_max_error = Vol(idx);
max_P1 = max(P1);
max_P2 = max(P2);
max_P = max(max_P1, max_P2);
min_V = min(V);

fprintf('Maximum Error: %.2f%% at Volume: %.2f\n', max_error, V_max_error);

figure;
for i = 1:length(Vol)
    ax = gca;
     if min_V < Vol(i)
        xlim([min_V, Vol(i)]);
    end
    current_max_pressure = max(max(P1(1:i)), max(P2(1:i))); 
    ylim([0, current_max_pressure * 1.1]);
    
    plot(Vol(1:i), P1(1:i),'color','b', 'DisplayName', 'Ideal Gas Law');
    plot(Vol(1:i), P2(1:i),'color','r', 'DisplayName', 'Van der Waals');    
    hold on
    plot(Vol(1:i), P1(1:i), 'x','color','b', 'Markersize', 2, 'LineWidth',1);
    plot(Vol(1:i), P2(1:i), 'x','color','r','Markersize', 2,'LineWidth',1);
    
    x_lim = xlim;
    y_lim = ylim;
    
    x_norm = (Vol(i) - x_lim(1)) / (x_lim(2) - x_lim(1));
    y_norm_P1 = (P1(i) - y_lim(1)) / (y_lim(2) - y_lim(1));
    y_norm_P2 = (P2(i) - y_lim(1)) / (y_lim(2) - y_lim(1));
    
    annotation('arrow', ax.Position([1 3]), ax.Position([2 4]), ...
        'Position', [ax.Position(1) ax.Position(2) x_norm*ax.Position(3) y_norm_P1*ax.Position(4)], ...
        'Color', 'b', 'LineWidth', 1.5, 'HeadLength', 10, 'HeadWidth', 5);
    
    annotation('arrow', ax.Position([1 3]), ax.Position([2 4]), ...
        'Position', [ax.Position(1) ax.Position(2) x_norm*ax.Position(3) y_norm_P2*ax.Position(4)], ...
        'Color', 'r', 'LineWidth', 1.5, 'HeadLength', 10, 'HeadWidth', 5);
    
    hold on;

    xlabel('Volume (V)');
    ylabel('Pressure (Pa)');
    title('Pressure vs Volume for Ideal Gas and Van der Waals Gas');
    grid on;

    legend('Ideal Gas Law', 'Van der Waals');


    if i > 1
        delta_P1 = abs(P1(i) - P1(i-1));
        delta_P2 = abs(P2(i) - P2(i-1));
        delta_P = max(delta_P1, delta_P2);
        pause_duration = delta_P/30;
    else
        pause_duration = 0.25;
    end
    pause(pause_duration);

    if i < length(Vol)
        clf;
        xlabel('Volume (V)');
        ylabel('Pressure (Pa)');
        title('Pressure vs Volume for Ideal Gas and Van der Waals Gas');
        grid on;
        hold on;
    end
end

hold off;
