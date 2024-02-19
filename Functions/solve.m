function [t,y] = solve(sys)
% solve 
% initial value problem

%%
y0=[sys.u0;sys.v0;sys.V*cos(sys.gamma);sys.V*sin(sys.gamma)];
tspan = linspace(0,sys.T,15000);
opt    = odeset('Events', @sys.myEvent);
[t,y] = ode45(@sys.odeRhs,tspan,y0, opt);

end

