function [Strain] = StressTrans(S, theta)
    sigma_xx = S(1);
    sigma_yy = S(2);
    tau_xy = S(3);

    sigma_xx_prime = (sigma_xx + sigma_yy)/2 + (sigma_xx - sigma_yy)/2 * cos(2*theta) + tau_xy * sin(2*theta);
    sigma_yy_prime = (sigma_xx + sigma_yy)/2 - (sigma_xx - sigma_yy)/2 * cos(2*theta) - tau_xy * sin(2*theta);
    tau_xy_prime = -(sigma_xx - sigma_yy)/2 * sin(2*theta) + tau_xy * cos(2*theta);

    Strain = [sigma_xx_prime, sigma_yy_prime, tau_xy_prime];
end

sigma_xx = input('Enter the stress component sigma_xx (in Pa): ');
sigma_yy = input('Enter the stress component sigma_xx_yy (in Pa): ');
tau_xy = input('Enter the shear stress component tau_xy (in Pa): ');

S = [sigma_xx, sigma_yy, tau_xy];

theta_degrees = input('Enter the angle (in degrees): ');
theta = deg2rad(theta_degrees); % Convert degrees to radians

Strain = StressTrans(S, theta);
fprintf('Strain = [%.2f, %.2f, %.2f]\n', Strain(1),Strain(2),Strain(3));
fprintf('Transformed stresses:\n');
fprintf('sigma_x''x'' = %.2f Pa\n', Strain(1));
fprintf('sigma_y''y'' = %.2f Pa\n', Strain(2));
fprintf('tau_x''y'' = %.2f Pa\n', Strain(3));
