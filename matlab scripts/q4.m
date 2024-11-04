fprintf('V = OB * (OA x AC)\n')
disp('-------------------------------')

% Prompt user for inputs
A = input('Enter point A (in Cartesian coordinates, e.g., [1 2 3]): ');
B = input('Enter point B (in Cartesian coordinates, e.g., [4 5 6]): ');
C = input('Enter point C (in Cartesian coordinates, e.g., [7 8 9]): ');

% Calculate vectors OA, OB, and AC
OA = A;
OB = B;
AC = C-A;

% Calculate the cross product and dot product
OAcrossAC = cross(OA, AC);
OBdotOAcrossAC = dot(OB, OAcrossAC);

% Display intermediate results and final value
disp('-------------------------------')
fprintf('Cross product (OA x AC) = [%d %d %d]\n', OAcrossAC);
fprintf('Dot product OB * (OA x AC) = %d\n', OBdotOAcrossAC);
fprintf('V = %d\n', OBdotOAcrossAC);
