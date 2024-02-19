function postprocess(sys,t,y)
%postprocess
%%   plot all functions

hold on;
% track
plot(y(:,1),y(:,2),'-');
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
end

