%% Collection de donnees AG 806_808 ---> changer
clear;
clc;
close all;
%% transformateur 
frequence = 60; % Hz
% station
Dpha = 0;      % degrer
Dphb = -120;   % degrer
Dphc = +120;   % degrer
%% load variable
% Assuming MATLoader.java has already loaded these from the 'data/' subdirectory
% If not, or for standalone script execution, load from 'data/'
load('data/DistanceDeLigne.mat');
load('data/variable.mat');      % Km
%% charges
% --> load les matrice de charge du excel
% CSVLoader.java creates variables 'activeA', 'activeB', etc. from 'data/*.xlsx'
% The script can either use these directly or re-read from the 'data/' subdirectory.
% Using pre-loaded variables (if names match what the script expects):
% activeAs = activeA; % If CSVLoader created 'activeA' and this script needs 'activeAs'
% reactiveAs = reactiveA; % etc.
% OR, make the script load from the 'data' subdirectory:
activeAs = xlsread('data/activeA.xlsx','C4:AJ37'); % Ensure activeA.xlsx is in matlab/data
activeBs = xlsread('data/activeB.xlsx','C4:AJ37'); % Ensure activeB.xlsx is in matlab/data
activeCs = xlsread('data/activeC.xlsx','C4:AJ37'); % Ensure activeC.xlsx is in matlab/data
reactiveAs_data = xlsread('data/reactiveA.xlsx','C4:AJ37'); % Renaming to avoid conflict if 'reactiveA' is a function
reactiveBs_data = xlsread('data/reactiveB.xlsx','C4:AJ37');
reactiveCs_data = xlsread('data/reactiveC.xlsx','C4:AJ37');
% --> charge capacitive en parallel
% --> noeud 844
Qc844 = [100e3 100e3 100e3];
% --> noeud 848
Qc848 = [150e3 150e3 150e3];
%% Collect AG 806_808 ---> changer
Ia_AG806_808 = zeros(size(variable, 1), 1); % ---> changer
Ib_AG806_808 = zeros(size(variable, 1), 1); % ---> changer
Ic_AG806_808 = zeros(size(variable, 1), 1); % ---> changer
disdefi = [Ltot_806_808 * 0.05, Ltot_806_808 * 0.15, Ltot_806_808 * 0.25, Ltot_806_808 * 0.35, Ltot_806_808 * 0.45, Ltot_806_808 * 0.55, Ltot_806_808 * 0.65, Ltot_806_808 * 0.75, Ltot_806_808 * 0.85, Ltot_806_808 * 0.95];
parfor a = 1:1:size(variable, 1)
    Vstation = variable(a, 1);   % Kv
    Ustation = variable(a, 2);   % Kv
    current_activeA = activeAs * variable(a, 3); % Use a different name if 'activeA' is from CSVLoader
    current_activeB = activeBs * variable(a, 4);
    current_activeC = activeCs * variable(a, 5);
    RF1 = variable(a, 6);
    disdef = variable(a, 7);
    % Pass the correct reactive power variables, e.g., reactiveAs_data
    [Ia806_808, Ib806_808, Ic806_808] = CourantCCabc(Vstation, Ustation, current_activeA, current_activeB, current_activeC, reactiveAs_data, reactiveBs_data, reactiveCs_data, RF1, disdef);
    Ia_AG806_808(a, :) = Ia806_808; % ---> changer
    Ib_AG806_808(a, :) = Ib806_808; % ---> changer
    Ic_AG806_808(a, :) = Ic806_808; % ---> changer
end
clc;
disp('------ > Collection Termier');