function KW14_postprocess(sys,B)
%postprocess
%   plot all functions

% local x-coordinates
x1 = linspace(0,2,20);
x2 = linspace(0,1,10);

% plot array
tiledlayout(4,1);
% plot
nexttile;
w = [[ 0 , 4/3*B(4), 4*B(3), 8*B(2), 8*B(1)];...
     [1/3, 4/3*B(8), 4*B(7), 8*B(6), 8*B(5)]];

plot(x1,polyval(w(1,:),x1),'-',2+x2,polyval(w(2,:),x2),'-');
grid on;
set(gca, 'YDir','reverse');
title('w(x)/w_{ref}');
legend({'w_1(x)','w_2(x)'},'Location','northwest')
xlabel('x/a →')
ylabel('← w')

% plot
nexttile;
phi = [[ 0 , 0, 3*B(4), 6*B(3), 6*B(2)];...
       [ 0 , 1, 3*B(8), 6*B(7), 6*B(6)]];

plot(x1,polyval(phi(1,:),x1),'-',2+x2,polyval(phi(2,:),x2),'-');
grid on;
set(gca, 'YDir','reverse');
title('φ(x)/φ_{ref}');
legend({'φ_1(x)','φ_2(x)'},'Location','northwest')
xlabel('x/a →')
ylabel('← φ')

% plot
nexttile;
m = [[ 0 , 0, 0, -2*B(4), -2*B(3)];...
     [ 0 , 0,-1, -2*B(8), -2*B(7)]];

plot(x1,polyval(m(1,:),x1),'-',2+x2,polyval(m(2,:),x2),'-');
grid on;
title('M(x)/M_{ref}');
legend({'M_1(x)','M_2(x)'},'Location','northwest')
xlabel('x/a →')
ylabel('M →')


% plot
nexttile;
q = [[ 0 , 0, 0,  0, -1*B(4)];...
     [ 0 , 0, 0, -1, -1*B(8)]];

plot(x1,polyval(q(1,:),x1),'-',2+x2,polyval(q(2,:),x2),'-');
grid on;
title('Q(x)/Q_{ref}');
legend({'Q_1(x)','Q_2(x)'},'Location','northwest')
xlabel('x/a →')
ylabel('Q →')

end

