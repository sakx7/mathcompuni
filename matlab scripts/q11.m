function [Strain]=StressTrans(S,theta)
    % split the vector into accessable parts for the equations
    sigma_xx=S(1);
    sigma_yy=S(2);
    tau_xy=S(3);

    % Calculate the equations
    sigma_xx_prime=(sigma_xx+sigma_yy)/2+(sigma_xx-sigma_yy)/2*cos(2*theta)+tau_xy*sin(2*theta);
    sigma_yy_prime=sigma_xx+sigma_yy-sigma_xx_prime;
    tau_xy_prime=-(sigma_xx-sigma_yy)/2*sin(2*theta)+tau_xy*cos(2*theta);

    % Define Strain to return    
    Strain=[sigma_xx_prime,sigma_yy_prime,tau_xy_prime];
end

% Get inputs
sigma_xx=input('Enter the stress component sigma_xx (in Pa): ');
sigma_yy=input('Enter the stress component sigma_yy (in Pa): ');
tau_xy=input('Enter the shear stress component tau_xy (in Pa): ');
theta_degrees=input('Enter the angle (in degrees): ');

% Convert into what will/can be put into the function
theta=deg2rad(theta_degrees);
S=[sigma_xx,sigma_yy,tau_xy];

% Call it and get the Strain out
[Strain]=StressTrans(S,theta);

% Display in console
fprintf('\n------------------------------------\n');
fprintf('Transformed stresses:\n');
fprintf('sigma_x''x'' = %.2f Pa\n',Strain(1));
fprintf('sigma_y''y'' = %.2f Pa\n',Strain(2));
fprintf('tau_x''y'' = %.2f Pa\n',Strain(3));
disp('------------------------------------');
fprintf('Strain = [%.2f, %.2f, %.2f]\n\n',Strain(1),Strain(2),Strain(3));