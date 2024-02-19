function postprocess(sys,t,y,select)
%postprocess
%%   plot all functions

if select == 1 
    hold on;
    % track
    plot(y(:,1),y(:,2),'.-');
    % obstacles
    t = linspace(0,2*pi);
    for o=1:length(sys.x)
        plot(sys.x(o)+sys.R*sin(t),sys.y(o)+sys.R*cos(t))    
    end
    %plot(sys.x,sys.y,'Marker', 'o', 'MarkerSize', 20, ...
    %     'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');
    grid on;
    title('track');
    xlim([0 sys.l(1)]);
    ylim([0 sys.l(2)]);
    xlabel('u/l_1 →');
    ylabel('v/l_2 →');
    pbaspect([1 sys.l(2)/sys.l(1) 1]);
    hold off;
else
    O=[];
    B=[];
    for s=1:length(t)
        o = transpose(sys.obstacle(transpose(y(s,1:2))));
        O(s,1) = sqrt(dot(o,o));
        b = transpose(sys.border(  transpose(y(s,1:2))));
        B(s,1) = sqrt(dot(b,b));
    end
       
    %% plot array
    tiledlayout(2,1);
    % plot
    nexttile;
    plot(t, y(:,1),'-',t, y(:,2),'-');
    grid on;
    title('u/m, v /m');
    legend({'u','v'},'Location','northwest')
    xlabel('t →')
    ylabel('y →')
    ylim([0 max(sys.l(1),sys.l(2))]);
    %% plot
    nexttile;

    plot(t, O(:,1),'-',t, B(:,1),'-');
    grid on;
    title('Forces');
    legend({'O(t)','B(t)'},'Location','northwest')
    xlabel('t/s →')
    ylabel('F/N →')

end
end

