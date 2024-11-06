% Define time range
t=linspace(0,4,1000);

% Define displacement and velocity functions
x=@(t)4.219*(exp(-1.58*t)-exp(-6.32*t));
v=@(t)26.67*exp(-6.32*t)-6.67*exp(-1.58*t);

% Create figure
figure('Position',[100,100,800,600]);

% Plot displacement
subplot(2,2,1)
plot(t,x(t))
title('Displacement vs Time')
xlabel('Time (s)')
ylabel('Displacement (m)')
grid on

% Plot velocity
subplot(2,2,2)
plot(t,v(t))
title('Velocity vs Time')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on

% Plot both displacement and velocity
subplot(2,1,2)
yyaxis left
plot(t,x(t),'DisplayName','Displacement')
ylabel('Displacement (m)')
yyaxis right
plot(t,v(t),'DisplayName','Velocity')
ylabel('Velocity (m/s)')
title('Displacement and Velocity vs Time')
xlabel('Time (s)')
grid on
legend;

% Save as a PNG image
print('-dpng','-r300','railroad_bumper_plots.png')