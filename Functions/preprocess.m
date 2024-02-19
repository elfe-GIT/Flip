function sys = KW14_preprocess(fileName)
% preprocess
%   read data and initialize class
p = readtable(fileName,'Sheet','Aufgabe 3.16','Range','B2:F20','ReadRowNames',true);
data = p(:,{'number','unit'});

sys = EBB(data);
end

