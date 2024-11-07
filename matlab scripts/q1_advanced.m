function interactive_parabola()
    % This is merely an imitation of the Python version that works a lot better.
    % I hope the LaTeX renders correctly for you; 
    % my render engine seems to be somewhat erratic. Works but not clean.
    % Use OpenGL, see if it does well there.

    % Set renderer to 'painters'
    currentRenderer=get(0,'DefaultFigureRenderer');
    if ~strcmp(currentRenderer,'painters') 
        fprintf('Current Default Figure Renderer: %s\n',currentRenderer);
        set(0,'DefaultFigureRenderer','painters');
        newRenderer=get(0,'DefaultFigureRenderer');
        fprintf('New Default Figure Renderer: %s\n',newRenderer);
    end

    % Initialize parameters
    initial_a=11.0;
    initial_b=9.0;
    
    % Create figure and axes
    fig=figure('Position',[100,100,1000,600]);
    ax=axes('Parent',fig,'Position',[0.1,0.3,0.8,0.6]);
    function applyAxesFormatting(ax)
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.TickDir = 'out';
        ax.FontName = 'Calibri';
        ax.FontSize = 12;
    end
    
    % Create sliders and reset button
    slider_a=uicontrol('Style','slider','Min',0.1,'Max',20,'Value',initial_a,...
        'Units','normalized','Position',[0.1 0.1 0.8 0.03],'Callback',@update_plot);
    slider_b=uicontrol('Style','slider','Min',0.1,'Max',20,'Value',initial_b,...
        'Units','normalized','Position',[0.1 0.05 0.8 0.03],'Callback',@update_plot);
    reset_button=uicontrol('Style','pushbutton','String','Reset',...
        'Units','normalized','Position',[0.8 0.025 0.1 0.04],'Callback',@reset_sliders);
    
    update_plot();
    
    % Function to update plot based on slider values
    function update_plot(~,~)
        a=get(slider_a,'Value');
        b=get(slider_b,'Value');
        
        % Calculate arc length
        L_ABC=(1/2)*sqrt(b^2+16*a^2)+(b^2/(8*a))*log((4*a+sqrt(b^2+16*a^2))/b);
        
        % Generate parabola points
        x=linspace(-10,10,400);
        y=-((2*sqrt(a))*x/b).^2+a;
        
        % Plot parabola and key points
        cla(ax);
        applyAxesFormatting(ax)
        plot(ax,x,y,'b','DisplayName','$y=-\left(\frac{2\sqrt{a}}{b}x\right)^2+a$')
        hold(ax,'on')
        plot(ax,[0,0],[0,a],'r','DisplayName','a (height)');
        plot(ax,[-b/2,b/2],[0,0],'g','DisplayName','b (width)');
        
        A_x=-b/2;
        C_x=b/2;
        plot(ax,A_x,0,'o','Color',[0.5,0,0.5],'MarkerFaceColor',[0.5,0,0.5],'DisplayName','Point A');
        plot(ax,0,a,'o','Color',[1,0.65,0],'MarkerFaceColor',[1,0.65,0],'DisplayName','Point B');
        plot(ax,C_x,0,'o','Color',[0.5,0,0.5],'MarkerFaceColor',[0.5,0,0.5],'DisplayName','Point C');
        
        % Add labels
        text(ax,A_x,0,' A','Color',[0.5,0,0.5],'VerticalAlignment','top','HorizontalAlignment','center');
        text(ax,0,a,' B','Color',[1,0.65,0],'VerticalAlignment','middle','HorizontalAlignment','right');
        text(ax,C_x,0,' C','Color',[0.5,0,0.5],'VerticalAlignment','top','HorizontalAlignment','center');
        
        title(ax,'Arc Length Calculation');
        
        % Create equation string
        a_value=num2str(a,'%.2f');
        b_value=num2str(b,'%.2f');
        b_squared=num2str(b^2,'%.2f');
        sqrt_term=sprintf('\\sqrt{%s+16(%s)^2}',b_squared,a_value);
        
        eq_str_template=['$\\displaystyle L_{ABC}=\\frac{1}{2}{%s}+\\frac{%s}{8(%s)}'...
                         '\\ln\\left(\\frac{4(%s)+{%s}}{%s}\\right)'...
                         '\\approx%.2f$'];
        
        eq_str=sprintf(eq_str_template,sqrt_term,b_squared,a_value,...
                       a_value,sqrt_term,b_value,L_ABC);
        
        % Display equation
        text(ax,0.5,-0.15,eq_str,'Units','normalized',...
             'HorizontalAlignment','center','VerticalAlignment','top',...
             'Interpreter','latex','FontSize',10);

        % Set axis limits and properties
        ylim(ax,[ -1,a+1]);
        xlim(ax,[ -b/2-1,b/2+1]);
        
        grid(ax,'on');
        leg=legend(ax,'Location','northwest');
        set(leg,'Interpreter','latex');        
        set(ax,'TickLabelInterpreter','latex');
        hold(ax,'off');
    end

    % Function to reset sliders to initial values
    function reset_sliders(~,~)
        set(slider_a,'Value',initial_a);
        set(slider_b,'Value',initial_b);
        update_plot();
    end
end