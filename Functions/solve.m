function x = solveAb(sys)
%solve 
%   linear system of equations A*x = b
A = sys.sysmat();
b = sys.rhs();

x = linsolve(A,b);
end

