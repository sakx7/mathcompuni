function wheatstone_bridge_ui()
    % create a UI figure
    fig = uifigure('Name', 'Wheatstone Bridge Circuit Calculator', 'Position', [100, 100, 600, 400]);

    % image stuff dont worry bout this 
    imgURL = 'https://raw.githubusercontent.com/sakx7/mathcompuni/main/figures/wheatstone_bridge.jpg'; 
    localImgPath = fullfile(pwd, 'wheatstone_bridge.jpg');
    if ~isfile(localImgPath)
        try
            websave(localImgPath, imgURL);
        catch
            uialert(fig, 'Failed to download the image.', 'Download Error');
            return;
        end
    end
    img = uiimage(fig);
    img.Position = [25, 75, 250, 250];
    img.ImageSource = localImgPath;

    % add input labels and fields on the right side
    voltageLabel = uilabel(fig, 'Text', '$V$ ($V$/volts):', 'Position', [333, 300, 100, 30], 'Interpreter', 'latex');
    voltageField = uieditfield(fig, 'numeric', 'Position', [405, 300, 100, 30]);

    r1Label = uilabel(fig, 'Text', '$R_1$ ($\Omega$/ohms):', 'Position', [325, 250, 100, 30], 'Interpreter', 'latex');
    r1Field = uieditfield(fig, 'numeric', 'Position', [405, 250, 100, 30]);

    r2Label = uilabel(fig, 'Text', '$R_2$ ($\Omega$/ohms):', 'Position', [325, 200, 100, 30], 'Interpreter', 'latex');
    r2Field = uieditfield(fig, 'numeric', 'Position', [405, 200, 100, 30]);

    r3Label = uilabel(fig, 'Text', '$R_3$ ($\Omega$/ohms):', 'Position', [325, 150, 100, 30], 'Interpreter', 'latex');
    r3Field = uieditfield(fig, 'numeric', 'Position', [405, 150, 100, 30]);

    r4Label = uilabel(fig, 'Text', '$R_4$ ($\Omega$/ohms):', 'Position', [325, 100, 100, 30], 'Interpreter', 'latex');
    r4Field = uieditfield(fig, 'numeric', 'Position', [405, 100, 100, 30]);

    % add label for result
    outputLabel = uilabel(fig, 'Position', [25, 20, 250, 50], 'Text', 'Output will be displayed here.', 'FontSize', 14, 'Interpreter', 'latex');

    % add button
    calcButton = uibutton(fig, 'push', ...
        'Text', 'Calculate $V_{ab}$', ...
        'Position', [375, 50, 150, 30], ...
        'Interpreter', 'latex', ...
        'ButtonPushedFcn', @(calcButton,event) calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputLabel)); % Use outputLabel
end

% Main gunction to calculate weat (V_ab) and display the result
function calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputLabel)
    % get values from the input fields
    V = voltageField.Value;
    R_1 = r1Field.Value;
    R_2 = r2Field.Value;
    R_3 = r3Field.Value;
    R_4 = r4Field.Value;

    % input validation error handles
    inputs = [V, R_1, R_2, R_3, R_4];
    if any(isnan(inputs)) || any(inputs <= 0)
        uialert(fig, 'enter valid values.', 'Input Error');
        return;
    end

    % the weat
    V_ab = V * (R_1 * R_3 - R_2 * R_4) / ((R_1 + R_2) * (R_3 + R_4));

    % final display result in the label
    msg = sprintf('The output voltage $V_{ab}$ is: %.4f V', V_ab);
    outputLabel.Text = msg;  % update the label with the output message
end
