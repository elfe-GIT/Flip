%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Modul Numerische Methoden der Mechanik                            %
% Script zur Berechnung der Bahn einer Punktmasse                   %
% auf einer schiefen Ebene mit Hindernissen                         %
% Autor: Andreas Baumgart                                           %
% Last Update: 2024-02-19                                           %
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% set working directory
cd("C:\Users\abs384\OneDrive - HAW-HH\Confluence Sources\Flip\Matlab")
addpath("./Classes","./Functions");

%% preprocess
fileName = "parameter.xlsx";

%% read system information
sys = preprocess(fileName);

%% solve y' = f(y)
[t,y] = solve(sys);

%% plot results
postprocess(sys,t,y,2);

VE = y(length(t),3:4);
disp(['velocity-ratio: ',num2str(sys.V/sqrt(dot(VE,VE)))]);
%% EOF