function LissajouseCurveTable(n,save,step,memory,gap)
    % n, default = 4; % size of the table, i.e. number of rows and columns   
    % step, default = 0.01; % step size between two points
    % memory, default = .95; % the perscentage of one period to be shown
    % gap, default = .3; % gap size between curves in the plot
    % save, default = 0; % whether to save png files
    
    % initialization:
    if nargin < 5
        gap = .3; % gap size between curves in the plot
        if nargin < 4
            memory = .95; % the perscentage of one period to be shown
            if nargin < 3
                step = 0.01; % step size between two points
                if nargin < 2
                    save = 0; % whether to save png files
                    if nargin < 1
                        n = 4;
                    end
                end
            end
        end
    end
    
    

    % pre-assign
    x = zeros(1,n); % the x coordinates of all curves
    y = zeros(1,n); % the y coordinates of all curves
    a = (2+2*gap)*[1:n]; % the horizontal and vertical align for the grid
    vl = zeros(1,n+1); % vertical lines
    hl = zeros(1,n+1); % horizontal lines
    xlims = [-1-gap,(2*n+1)*(gap+1)+gap]; % horzintal limits of the visible area 
    ylims = [-1-gap,(2*n+1)*(gap+1)+gap]; % vertical limits of the visible area 

    % plot
    f = figure();
    set(f,'position',[1,1,700,700]) % size of the figure
    f.Color = 'black';
    box off
    axis off
    f.InvertHardcopy = 'off';
    set(gca, 'color', [0,0,0]) % background color
    xlim(xlims) % set the horizontal visible area
    ylim(ylims) % set the vertical visible area

    set(gca,'XTick',[]) % delete the marks on the axes
    set(gca,'YTick',[]) % delete the marks on the axes
    axis square % make the axes equal
    hold on % keep everything

    t = 0; % step numer
    while true % do this for ever
        t = t+1; % take a step
        T = t*pi*step; % calculate the time
        for i = 1:n
            x(i) = cos(i*T + pi/2); % calculate x coordinates
            y(i) = sin(i*T + pi/2); % calculate y coordinates

            vl(i) = plot([a(i)+x(i) a(i)+x(i)], ylims, '-', 'color',[0,1,1,.5]); % draw vertical lines
            hl(i) = plot(xlims, [a(i)+y(i) a(i)+y(i)], '-', 'color',[0,1,1,.5]); % dray horizontal lines

            HP(i,t) = plot(a(i)+x(i),y(i),'y.','markersize',10); % plot horizontal circles
            HQ(i,t) = t; % birth time

            VP(i,t) = plot(x(i),a(i)+y(i),'y.','markersize',10); % plot vertical circle
            VQ(i,t) = t; % birth time
        end

        for i = 1:n 
            for j = 1:n
                P(i,j,t) = plot(a(i)+x(i),a(j)+y(j),'y.','markersize',10); % plot curves
                Q(i,j,t) = t; % birth time
            end
        end

        pause(0.00001)
        if save
            % save this frame as a png file
            saveas(gcf,['LissajouseCurveTable_' num2str(n) 'x' num2str(n) 'f' num2str(t) 's' num2str(step) '.png'])
        end

        for i = 0:min(3,t-1) % reduce marker sizes
            set(P(:,:,t-i),'markersize',8-i)
            set(HP(:,t-i),'markersize',8-i)
            set(VP(:,t-i),'markersize',8-i)
        end

        delete(vl) % delete vertical lines
        delete(hl) % delete horizontal lines

        delete(P(t - Q > 2*memory/step)) % delete old points on the curves
        delete(HP(t - HQ > 2*memory/step)) % delete old points on the curves
        delete(VP(t - VQ > 2*memory/step)) % delete old points on the curves
    end
end