function wheatstone_bridge_ui()
    % Create a UI figure
    fig = uifigure('Name', 'Wheatstone Bridge Circuit Calculator', 'Position', [100, 100, 600, 400]);

    % add an image on the left side
    try
        img = uiimage(fig);
        img.Position = [25, 75, 250, 250];
        img.ImageSource = 'wheatstone_bridge.jpg';  % replace with image file from figures folder in my git
    catch
        uialert(fig, 'Image file not found. Please ensure the image is in the same dir, get from my gitHub.', 'Image Error');
        return;
    end

    % Add input labels and fields on the right side
    voltageLabel = uilabel(fig, 'Text', 'Voltage (V):', 'Position', [325, 300, 100, 30]);
    voltageField = uieditfield(fig, 'numeric', 'Position', [450, 300, 100, 30]);

    r1Label = uilabel(fig, 'Text', 'Resistor R_1 (Ω):', 'Position', [325, 250, 100, 30]);
    r1Field = uieditfield(fig, 'numeric', 'Position', [450, 250, 100, 30]);

    r2Label = uilabel(fig, 'Text', 'Resistor R_2 (Ω):', 'Position', [325, 200, 100, 30]);
    r2Field = uieditfield(fig, 'numeric', 'Position', [450, 200, 100, 30]);

    r3Label = uilabel(fig, 'Text', 'Resistor R_3 (Ω):', 'Position', [325, 150, 100, 30]);
    r3Field = uieditfield(fig, 'numeric', 'Position', [450, 150, 100, 30]);

    r4Label = uilabel(fig, 'Text', 'Resistor R_4 (Ω):', 'Position', [325, 100, 100, 30]);
    r4Field = uieditfield(fig, 'numeric', 'Position', [450, 100, 100, 30]);

    % add a text area to display the output voltage
    outputText = uitextarea(fig, 'Position', [25, 20, 250, 50], 'Editable', 'off', 'Value', {'Output will be displayed here.'});

    % add a button to calculate the output voltage
    calcButton = uibutton(fig, 'push', 'Text', 'Calculate V_ab', 'Position', [375, 50, 150, 30], ...
        'ButtonPushedFcn', @(calcButton,event) calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputText));
end

% function to calculate V_ab and display the result
function calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputText)
    % get values from input fields
    V = voltageField.Value;
    R_1 = r1Field.Value;
    R_2 = r2Field.Value;
    R_3 = r3Field.Value;
    R_4 = r4Field.Value;
    
    % input validation
    inputs = [V, R_1, R_2, R_3, R_4];
    if any(isnan(inputs)) || any(inputs <= 0)
        uialert(fig, 'Please enter valid positive numeric values for all fields.', 'Input Error');
        return;
    end
    
    % calculate V_ab
    V_ab = V * (R_1 * R_3 - R_2 * R_4) / ((R_1 + R_2) * (R_3 + R_4));

    % display result in the text area
    msg = sprintf('The output voltage V_ab is: %.4f V', V_ab);
    outputText.Value = {msg};  % update the text area with the output message
end
