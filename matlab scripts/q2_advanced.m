
function wheatstone_bridge_ui()
    
    fig = uifigure('Name', 'Wheatstone Bridge Circuit Calculator', 'Position', [100, 100, 1000, 700],'Resize','off');

    imgURL = 'https://raw.githubusercontent.com/sakx7/mathcompuni/main/images/wheatstone_bridge.jpg'; 
    localImgPath = fullfile(pwd, 'wheatstone_bridge1.jpg');
    
    if ~isfile(localImgPath)
        try
            websave(localImgPath, imgURL);
        catch
            uialert(fig, 'Failed to download the image.', 'Download Error');
            return;
        end
    end
    
    img = uiimage(fig);
    img.Position = [50, 50, 900, 700];
    img.ImageSource = localImgPath;
    

    voltageField = uieditfield(fig, 'numeric', 'Position', [190, 450, 50, 30]);
    voltageLabel = uilabel(fig, 'Text', '$V$', 'Position', [voltageField.Position(1) + voltageField.Position(3), 450, 100, 30], 'Interpreter', 'latex');

    r1Field = uieditfield(fig, 'numeric', 'Position', [540, 465, 50, 30]);
    r1Label = uilabel(fig, 'Text', '$\Omega$', 'Position', [r1Field.Position(1) + r1Field.Position(3), 465, 100, 30], 'Interpreter', 'latex');

    r3Field = uieditfield(fig, 'numeric', 'Position', [700, 465, 50, 30]);
    r3Label = uilabel(fig, 'Text', '$\Omega$', 'Position', [r3Field.Position(1) + r3Field.Position(3), 465, 100, 30], 'Interpreter', 'latex');

    r2Field = uieditfield(fig, 'numeric', 'Position', [540, 300, 50, 30]);
    r2Label = uilabel(fig, 'Text', '$\Omega$', 'Position', [r2Field.Position(1) + r2Field.Position(3), 300, 100, 30], 'Interpreter', 'latex');

    r4Field = uieditfield(fig, 'numeric', 'Position', [700, 300, 50, 30]);
    r4Label = uilabel(fig, 'Text', '$\Omega$', 'Position', [r4Field.Position(1) + r4Field.Position(3), 300, 100, 30], 'Interpreter', 'latex');

    outputPanel = uipanel(fig, ...
        'Position', [600, 25, 300, 100], ...
        'BackgroundColor', 'white', ...
        'BorderType', 'line', ...
        'HighlightColor', 'black', ...
        'FontSize', 14);
    
    outputLabel = uilabel(outputPanel, ...
        'Position', [10, 10, 280, 80], ...
        'Text', 'Output will be displayed here.', ...
        'FontSize', 14, ...
        'Interpreter', 'latex', ...
        'HorizontalAlignment', 'center');

    calcButton = uibutton(fig, 'push', ...
        'Text', 'Calculate $V_{ab}$', ...
        'Position', [outputPanel.Position(1)-200, 60, 150, 30], ...
        'Interpreter', 'latex', ...
        'ButtonPushedFcn', @(calcButton,event) calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputLabel)); 

    equationpanel = uipanel(fig, ...
        'Position', [calcButton.Position(1) - 280, 45, 220, 60], ... 
        'BackgroundColor', 'white', ... 
        'BorderType', 'line', ...
        'HighlightColor', 'black', ...
        'FontSize', 14);
    
    equationLabel = uilabel(equationpanel, ... 
        'Position', [10, 10, 200, 40], ...
        'Text', '$V_{ab} = V \left(\frac{R_1 R_3 - R_2 R_4}{(R_1 + R_2)(R_3 + R_4)}\right)$', ...
        'FontSize', 14, ...
        'Interpreter', 'latex', ...
        'HorizontalAlignment', 'center');

end


% function to calculate V_ab and display the result
% This function updates the outputLabel directly with the result 
% instead of returning a value, so no output argument is specified.
function calculate_V_ab(fig, voltageField, r1Field, r2Field, r3Field, r4Field, outputLabel)
    V = voltageField.Value;
    R_1 = r1Field.Value;
    R_2 = r2Field.Value;
    R_3 = r3Field.Value;
    R_4 = r4Field.Value;
    inputs = [V, R_1, R_2, R_3, R_4];
    if any(isnan(inputs)) || any(inputs <= 0)
        uialert(fig, 'Enter valid values.', 'Input Error');
        return;
    end
    V_ab = V*(((R_1*R_3)-(R_2*R_4))/((R_1+R_2)*(R_3+R_4))) ;
    msg = sprintf('$V_{ab} = (%.2f)\\left(\\frac{(%.2f)(%.2f) - (%.2f)(%.2f)}{(%.2f+%.2f)(%.2f+%.2f)}\\right)$ \n The output voltage $V_{ab}$ is: %.4f V', ...
                  V, R_1, R_3, R_2, R_4, R_1, R_2, R_3, R_4, V_ab);

    outputLabel.Text = msg; 
end