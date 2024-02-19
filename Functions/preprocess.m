function sys = preprocess(fileName)
% preprocess
%   read data and initialize class
p = readtable(fileName,'Sheet','sources','Range','B2:F30','ReadRowNames',true);
data = p(:,{'number','unit'});
%%
sys = sources(data);
end

