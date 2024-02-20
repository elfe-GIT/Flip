function postprocess(sys,t,y)
%postprocess
%%   plot all functions

% contact forces ....
O=[];
B=[];
for s=1:length(t)
    o = transpose(sys.obstacle(transpose(y(s,1:2))));
    O(s,1) = sqrt(dot(o,o));
    b = transpose(sys.border(  transpose(y(s,1:2))));
    B(s,1) = sqrt(dot(b,b));
end

%% plot array
tiledlayout(2,2);
%% plot coordinates
nexttile;
plot(t, y(:,1),'-',t, y(:,2),'-');
grid on;
title('u/m, v /m');
legend({'u','v'},'Location','northwest')
xlabel('t/s →')
ylabel('u,v / m →')
ylim([0 max(sys.l(1),sys.l(2))]);

nexttile(2, [2,1]);
hold on;
%% track
plot(y(:,1),y(:,2),'.-');
% obstacles
phi=[0:0.1:2*pi];
for o=1:length(sys.x)
    plot(sys.x(o)+sys.R*sin(phi),sys.y(o)+sys.R*cos(phi))    
end
%plot(sys.x,sys.y,'Marker', 'o', 'MarkerSize', 20, ...
%     'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');
grid on;
title('track');
xlim([0 sys.l(1)]);
ylim([0 sys.l(2)]);
xlabel('u/m →');
ylabel('v/m →');
pbaspect([1 sys.l(2)/sys.l(1) 1]);
hold off;
%% ....
nexttile(3);
plot(t, O(:,1),'-',t, B(:,1),'-');
grid on;
title('Contact Forces');
legend({'O(t) (objects)','B(t) (borders)'},'Location','northwest')
xlabel('t/s →')
ylabel('F/N →')

end

