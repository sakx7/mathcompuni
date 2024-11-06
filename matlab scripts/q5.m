% Constant(s)
g=9.81;

% user inputs
u=input('Enter the initial velocity (u) in m/s: ');
theta=input('Enter the launch angle (theta) in degrees: ');
h=input('Enter the initial height (h) in meters: ');
fprintf('\n------------------------- Values of r(t) and theta(t) for t = 1,2,3,...31 -------------------------\n\n')
% initial calculations
theta_rad=deg2rad(theta);
u_x=u*cos(theta_rad);
u_y=u*sin(theta_rad);

% Compute flight characteristics
T=(u_y+sqrt(u_y^2+2*g*h))/g;
R=(u_x/g)*(u_y+sqrt(u_y^2+2*g*h));
H=(u_y^2/(2*g))+h;

% Generate time vector and calculate displacements
t=linspace(0,T,100); % since i named the time of flight its always gonna plot until it hits the ground
tp = 1:1:31;
s_x=u_x*t;
s_y=(u_y*t)-(0.5*g*t.^2)+h;

% Calculate radial distance and angle
r=sqrt(s_x.^2+s_y.^2);
theta_t=atan2(s_y,s_x);

x_tp=zeros(size(tp));
y_tp=zeros(size(tp));
r_tp=zeros(size(tp));
theta_tp=zeros(size(tp));

for i = 1:length(tp)
    tc=tp(i);
    x_tp(i)=u_x*tc;
    y_tp(i)=(u_y*tc)-(0.5*g*tc.^2)+h;
    r_tp(i) = sqrt(x_tp(i)^2 + y_tp(i)^2);
    theta_tp(i) = rad2deg(atan2(y_tp(i), x_tp(i)));    
    fprintf('r(%d) = %.2f, theta(%d) = %.2f\n',tc,r_tp(i),tc,theta_tp(i));
end

fprintf('\n-------------------------Simulation of full time of full flight-------------------------\n\n')
% Find maximum values for radial distance and angle
[max_r, max_r_index]=max(r);
max_time_r=t(max_r_index);
[max_theta,max_theta_index]=max(theta_t);
max_time_theta=t(max_theta_index);
max_theta_deg=rad2deg(max_theta);

% Calculate final velocity components and magnitude
v_x_T=u_x;
v_y_T=sqrt(u_y^2+2*g*h);
v_T=sqrt(v_x_T^2+v_y_T^2);

% Display calculated results
fprintf('Time of Flight (T): %.2f seconds\n',T);
fprintf('Range (R): %.2f meters\n',R);
fprintf('Max Height (H): %.2f meters\n',H);
fprintf('Velocity at separation (v(T)): %.2f m/s\n',v_T);
fprintf('Maximum radial distance (r(t)): %.2f meters at t = %.2f seconds\n',max_r,max_time_r);
fprintf('Maximum angle (theta(t)): %.2f degrees at t = %.2f seconds\n',max_theta_deg,max_time_theta);

% Set up the figure
figure('Position',[100,100,800,600]);

% Plot trajectory in Cartesian coordinates
subplot(2,1,1);
plot(s_x,s_y);
title('Projectile Motion Trajectory');
xlabel('Displacement in X (m)');
ylabel('Displacement in Y (m)');
grid on;
hold on;
plot(u_x*u_y/g,H,'x','MarkerSize',10,'LineWidth',2,'Color',[0.059,0.125,1],'DisplayName','Max Height');
legend('Trajectory','Max Height','Location','best');
hold off;

% Plot radial distance over time
subplot(2,2,3);
plot(t,r,'Color',[0,0.85,0],'DisplayName','r(t)');
hold on;
plot(max_time_r,max_r,'x','MarkerSize',10,'LineWidth',2,'Color',[0,0.85,0],'DisplayName','Max r(t)');
xlabel('Time (s)');
ylabel('Radial Distance (m)');
title('Radial Distance r(t)');
grid on;
legend('Location','best');
hold off;

% Plot angle theta(t) over time
subplot(2,2,4);
plot(t,rad2deg(theta_t),'r-','DisplayName','theta(t)');
hold on;
plot(max_time_theta,rad2deg(max_theta),'x','MarkerSize',10,'LineWidth',2,'Color','r','DisplayName','Max theta(t)');
xlabel('Time (s)');
ylabel('Angle theta(t) (degrees)');
title('Angle theta(t)');
grid on;
legend('Location','best');
hold off;

% Set overall title and save figure
sgtitle('Projectile Motion Analysis');
print('-dpng','-r300','Projectile_Motion.png')