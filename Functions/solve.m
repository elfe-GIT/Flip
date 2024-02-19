function [t,y] = solve(sys)
% solve 
% initial value problem

%%
y0=[sys.u0;sys.v0;sys.V*cos(sys.gamma);sys.V*sin(sys.gamma)];
tspan = [0,5];
[t,y] = ode45(@sys.odeRhs,tspan,y0);

end

