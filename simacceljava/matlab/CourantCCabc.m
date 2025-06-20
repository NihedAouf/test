function [Ia806_808, Ib806_808, Ic806_808] = CourantCCabc(Vstation, Ustation, activeA, activeB, activeC, reactiveA, reactiveB, reactiveC, RF1, disdef)
%% transformateur 
frequence = 60; % Hz
% station
Dpha = 0;      % degrer
Dphb = -120;   % degrer
Dphc = +120;   % degrer
%% lignes de transmissions
load('InductanceDeLigne.mat');    % H/Km
load('CapacitanceDeLigne.mat');   % F/Km
load('ResistanceDeLigne.mat');    % Ohm/Km
load('DistanceDeLigne.mat');      % Km 
load_system('SimulationAG806_808');
%% definir les parametre de simulink
% --> resistance de defaut
set_param('SimulationAG806_808/RF1','Resistance',num2str(RF1));
% --> source d'alimentation
set_param('SimulationAG806_808/Va','Amplitude',num2str(Vstation));
set_param('SimulationAG806_808/Va','Phase',num2str(Dpha));
set_param('SimulationAG806_808/Va','Frequency',num2str(frequence));
set_param('SimulationAG806_808/Vb','Amplitude',num2str(Vstation));
set_param('SimulationAG806_808/Vb','Phase',num2str(Dphb));
set_param('SimulationAG806_808/Vb','Frequency',num2str(frequence));
set_param('SimulationAG806_808/Vc','Amplitude',num2str(Vstation));
set_param('SimulationAG806_808/Vc','Phase',num2str(Dphc));
set_param('SimulationAG806_808/Vc','Frequency',num2str(frequence));
%% --> charges
% --> charge capacitive en parallel
% --> noeud 844
Qc844 = [100e3 100e3 100e3];
% --> noeud 848
Qc848 = [150e3 150e3 150e3];
% --> 802-806
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-A','ActivePower',num2str(activeA(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-A','InductivePower',num2str(reactiveA(2,3)/2));

set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-B','ActivePower',num2str(activeB(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-B','InductivePower',num2str(reactiveB(2,3)/2));

set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-C','ActivePower',num2str(activeC(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (1)-C','InductivePower',num2str(reactiveC(2,3)/2));

set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-A','ActivePower',num2str(activeA(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-A','InductivePower',num2str(reactiveA(2,3)/2));

set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-B','ActivePower',num2str(activeB(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-B','InductivePower',num2str(reactiveB(2,3)/2));

set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-C','ActivePower',num2str(activeC(2,3)/2));
set_param('SimulationAG806_808/charge distributive 802-806 Y-PQ (2)-C','InductivePower',num2str(reactiveC(2,3)/2));

% --> 808-810
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (1)','ActivePower',num2str(activeB(4,5)./2));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (1)','InductivePower',num2str(reactiveB(4,5)./2));

set_param('SimulationAG806_808/charge distributive 808-810 Y-I (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (2)','ActivePower',num2str(activeB(4,5)./2));
set_param('SimulationAG806_808/charge distributive 808-810 Y-I (2)','InductivePower',num2str(reactiveB(4,5)./2));

% --> 816-824
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-A','ActivePower',num2str(activeA(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-A','InductivePower',num2str(reactiveA(9,13)/2));

set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-B','ActivePower',num2str(activeB(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-B','InductivePower',num2str(reactiveB(9,13)/2));

set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-C','ActivePower',num2str(activeC(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (1)-C','InductivePower',num2str(reactiveC(9,13)/2));

set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-A','ActivePower',num2str(activeA(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-A','InductivePower',num2str(reactiveA(9,13)/2));

set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-B','ActivePower',num2str(activeB(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-B','InductivePower',num2str(reactiveB(9,13)/2));

set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-C','ActivePower',num2str(activeC(9,13)/2));
set_param('SimulationAG806_808/charge distributive 816-824 D-I (2)-C','InductivePower',num2str(reactiveC(9,13)/2));

% --> 818-820
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (1)','ActivePower',num2str(activeA(10,11)./2));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (1)','InductivePower',num2str(reactiveA(10,11)./2));

set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (2)','ActivePower',num2str(activeA(10,11)./2));
set_param('SimulationAG806_808/charge distributive 818-820 Y-Z (2)','InductivePower',num2str(reactiveA(10,11)./2));
% --> 820-822
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (1)','ActivePower',num2str(activeA(11,12)./2));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (1)','InductivePower',num2str(reactiveA(11,12)./2));

set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (2)','ActivePower',num2str(activeA(11,12)./2));
set_param('SimulationAG806_808/charge distributive 820-822 Y-PQ (2)','InductivePower',num2str(reactiveA(11,12)./2));

% --> 824-826
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (1)','ActivePower',num2str(activeB(13,14)./2));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (1)','InductivePower',num2str(reactiveB(13,14)./2));

set_param('SimulationAG806_808/charge distributive 824-826 Y-I (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (2)','ActivePower',num2str(activeB(13,14)./2));
set_param('SimulationAG806_808/charge distributive 824-826 Y-I (2)','InductivePower',num2str(reactiveB(13,14)./2));

% --> 824-828
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-A','ActivePower',num2str(activeA(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-A','InductivePower',num2str(reactiveA(13,15)/2));

set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-B','ActivePower',num2str(activeB(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-B','InductivePower',num2str(reactiveB(13,15)/2));

set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-C','ActivePower',num2str(activeC(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (1)-C','InductivePower',num2str(reactiveC(13,15)/2));

set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-A','ActivePower',num2str(activeA(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-A','InductivePower',num2str(reactiveA(13,15)/2));

set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-B','ActivePower',num2str(activeB(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-B','InductivePower',num2str(reactiveB(13,15)/2));

set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-C','ActivePower',num2str(activeC(13,15)/2));
set_param('SimulationAG806_808/charge distributive 824-828 Y-PQ (2)-C','InductivePower',num2str(reactiveC(13,15)/2));

% --> 828-830
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-A','ActivePower',num2str(activeA(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-A','InductivePower',num2str(reactiveA(15,16)/2));

set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-B','ActivePower',num2str(activeB(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-B','InductivePower',num2str(reactiveB(15,16)/2));

set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-C','ActivePower',num2str(activeC(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (1)-C','InductivePower',num2str(reactiveC(15,16)/2));

set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-A','ActivePower',num2str(activeA(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-A','InductivePower',num2str(reactiveA(15,16)/2));

set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-B','ActivePower',num2str(activeB(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-B','InductivePower',num2str(reactiveB(15,16)/2));

set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-C','ActivePower',num2str(activeC(15,16)/2));
set_param('SimulationAG806_808/charge distributive 828-830 Y-PQ (2)-C','InductivePower',num2str(reactiveC(15,16)/2));

% --> 832-858
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-A','ActivePower',num2str(activeA(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-A','InductivePower',num2str(reactiveA(20,23)/2));

set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-B','ActivePower',num2str(activeB(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-B','InductivePower',num2str(reactiveB(20,23)/2));

set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-C','ActivePower',num2str(activeC(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (1)-C','InductivePower',num2str(reactiveC(20,23)/2));

set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-A','ActivePower',num2str(activeA(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-A','InductivePower',num2str(reactiveA(20,23)/2));

set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-B','ActivePower',num2str(activeB(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-B','InductivePower',num2str(reactiveB(20,23)/2));

set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-C','ActivePower',num2str(activeC(20,23)/2));
set_param('SimulationAG806_808/charge distributive 832-858 D-Z (2)-C','InductivePower',num2str(reactiveC(20,23)/2));

% --> 834-860
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-A','ActivePower',num2str(activeA(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-A','InductivePower',num2str(reactiveA(25,30)/2));

set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-B','ActivePower',num2str(activeB(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-B','InductivePower',num2str(reactiveB(25,30)/2));

set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-C','ActivePower',num2str(activeC(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (1)-C','InductivePower',num2str(reactiveC(25,30)/2));

set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-A','ActivePower',num2str(activeA(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-A','InductivePower',num2str(reactiveA(25,30)/2));

set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-B','ActivePower',num2str(activeB(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-B','InductivePower',num2str(reactiveB(25,30)/2));

set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-C','ActivePower',num2str(activeC(25,30)/2));
set_param('SimulationAG806_808/charge distributive 834-860 D-Z (2)-C','InductivePower',num2str(reactiveC(25,30)/2));

% --> 836-840
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-A','ActivePower',num2str(activeA(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-A','InductivePower',num2str(reactiveA(31,34)/2));

set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-B','ActivePower',num2str(activeB(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-B','InductivePower',num2str(reactiveB(31,34)/2));

set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-C','ActivePower',num2str(activeC(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (1)-C','InductivePower',num2str(reactiveC(31,34)/2));

set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-A','ActivePower',num2str(activeA(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-A','InductivePower',num2str(reactiveA(31,34)/2));

set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-B','ActivePower',num2str(activeB(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-B','InductivePower',num2str(reactiveB(31,34)/2));

set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-C','ActivePower',num2str(activeC(31,34)/2));
set_param('SimulationAG806_808/charge distributive 836-840 D-I (2)-C','InductivePower',num2str(reactiveC(31,34)/2));

% --> 842-844
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-A','ActivePower',num2str(activeA(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-A','InductivePower',num2str(reactiveA(26,27)/2));

set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-B','ActivePower',num2str(activeB(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-B','InductivePower',num2str(reactiveB(26,27)/2));

set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-C','ActivePower',num2str(activeC(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (1)-C','InductivePower',num2str(reactiveC(26,27)/2));

set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-A','ActivePower',num2str(activeA(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-A','InductivePower',num2str(reactiveA(26,27)/2));

set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-B','ActivePower',num2str(activeB(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-B','InductivePower',num2str(reactiveB(26,27)/2));

set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-C','ActivePower',num2str(activeC(26,27)/2));
set_param('SimulationAG806_808/charge distributive 842-844 Y-PQ (2)-C','InductivePower',num2str(reactiveC(26,27)/2));

% --> 844-846
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-A','ActivePower',num2str(activeA(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-A','InductivePower',num2str(reactiveA(27,28)/2));

set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-B','ActivePower',num2str(activeB(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-B','InductivePower',num2str(reactiveB(27,28)/2));

set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-C','ActivePower',num2str(activeC(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (1)-C','InductivePower',num2str(reactiveC(27,28)/2));

set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-A','ActivePower',num2str(activeA(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-A','InductivePower',num2str(reactiveA(27,28)/2));

set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-B','ActivePower',num2str(activeB(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-B','InductivePower',num2str(reactiveB(27,28)/2));

set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-C','ActivePower',num2str(activeC(27,28)/2));
set_param('SimulationAG806_808/charge distributive 844-846 Y-PQ (2)-C','InductivePower',num2str(reactiveC(27,28)/2));

% --> 846-848
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-A','ActivePower',num2str(activeA(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-A','InductivePower',num2str(reactiveA(28,29)/2));

set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-B','ActivePower',num2str(activeB(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-B','InductivePower',num2str(reactiveB(28,29)/2));

set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-C','ActivePower',num2str(activeC(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (1)-C','InductivePower',num2str(reactiveC(28,29)/2));

set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-A','ActivePower',num2str(activeA(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-A','InductivePower',num2str(reactiveA(28,29)/2));

set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-B','ActivePower',num2str(activeB(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-B','InductivePower',num2str(reactiveB(28,29)/2));

set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-C','ActivePower',num2str(activeC(28,29)/2));
set_param('SimulationAG806_808/charge distributive 846-848 Y-PQ (2)-C','InductivePower',num2str(reactiveC(28,29)/2));

% --> 854-856
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (1)','ActivePower',num2str(activeB(17, 18)./2));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (1)','InductivePower',num2str(reactiveB(17, 18)./2));

set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (2)','ActivePower',num2str(activeB(17, 18)./2));
set_param('SimulationAG806_808/charge distributive 854-856 Y-PQ (2)','InductivePower',num2str(reactiveB(17, 18)./2));

% --> 858-834
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-A','ActivePower',num2str(activeA(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-A','InductivePower',num2str(reactiveA(23,25)/2));

set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-B','ActivePower',num2str(activeB(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-B','InductivePower',num2str(reactiveB(23,25)/2));

set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-C','ActivePower',num2str(activeC(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (1)-C','InductivePower',num2str(reactiveC(23,25)/2));

set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-A','ActivePower',num2str(activeA(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-A','InductivePower',num2str(reactiveA(23,25)/2));

set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-B','ActivePower',num2str(activeB(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-B','InductivePower',num2str(reactiveB(23,25)/2));

set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-C','ActivePower',num2str(activeC(23,25)/2));
set_param('SimulationAG806_808/charge distributive 858-834 D-PQ (2)-C','InductivePower',num2str(reactiveC(23,25)/2));

% --> 858-864
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (1)','ActivePower',num2str(activeA(23, 24)./2));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (1)','InductivePower',num2str(reactiveA(23, 24)./2));

set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (2)','ActivePower',num2str(activeA(23, 24)./2));
set_param('SimulationAG806_808/charge distributive 858-864 Y-PQ (2)','InductivePower',num2str(reactiveA(23, 24)./2));

% --> 860-836
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-A','ActivePower',num2str(activeA(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-A','InductivePower',num2str(reactiveA(30,31)/2));

set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-B','ActivePower',num2str(activeB(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-B','InductivePower',num2str(reactiveB(30,31)/2));

set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-C','ActivePower',num2str(activeC(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (1)-C','InductivePower',num2str(reactiveC(30,31)/2));

set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-A','ActivePower',num2str(activeA(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-A','InductivePower',num2str(reactiveA(30,31)/2));

set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-B','ActivePower',num2str(activeB(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-B','InductivePower',num2str(reactiveB(30,31)/2));

set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-C','ActivePower',num2str(activeC(30,31)/2));
set_param('SimulationAG806_808/charge distributive 860-836 D-PQ (2)-C','InductivePower',num2str(reactiveC(30,31)/2));

% --> 862-838
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (1)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (1)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (1)','ActivePower',num2str(activeB(32, 33)./2));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (1)','InductivePower',num2str(reactiveB(32, 33)./2));

set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (2)','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (2)','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (2)','ActivePower',num2str(activeB(32, 33)./2));
set_param('SimulationAG806_808/charge distributive 862-838 Y-PQ (2)','InductivePower',num2str(reactiveB(32, 33)./2));

% --> 830
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-A','ActivePower',num2str(activeA(16,16)));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-A','InductivePower',num2str(reactiveA(16,16)));

set_param('SimulationAG806_808/charge ponctuelle 830 DZ-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-B','ActivePower',num2str(activeB(16,16)));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-B','InductivePower',num2str(reactiveB(16,16)));

set_param('SimulationAG806_808/charge ponctuelle 830 DZ-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-C','ActivePower',num2str(activeB(16,16)));
set_param('SimulationAG806_808/charge ponctuelle 830 DZ-C','InductivePower',num2str(reactiveB(16,16)));

% --> 840
set_param('SimulationAG806_808/charge ponctuelle 840 YI-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-A','ActivePower',num2str(activeA(34,34)));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-A','InductivePower',num2str(reactiveA(34,34)));

set_param('SimulationAG806_808/charge ponctuelle 840 YI-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-B','ActivePower',num2str(activeB(34,34)));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-B','InductivePower',num2str(reactiveB(34,34)));

set_param('SimulationAG806_808/charge ponctuelle 840 YI-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-C','ActivePower',num2str(activeC(34,34)));
set_param('SimulationAG806_808/charge ponctuelle 840 YI-C','InductivePower',num2str(reactiveC(34,34)));

% --> 844
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-A','ActivePower',num2str(activeA(27,27)));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-A','InductivePower',num2str(reactiveA(27,27)));

set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-B','ActivePower',num2str(activeB(27,27)));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-B','InductivePower',num2str(reactiveB(27,27)));

set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-C','ActivePower',num2str(activeC(27,27)));
set_param('SimulationAG806_808/charge ponctuelle 844 Y-Z-C','InductivePower',num2str(reactiveC(27,27)));

% --> 848
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-A','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-A','ActivePower',num2str(activeA(29,29)));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-A','InductivePower',num2str(reactiveA(29,29)));

set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-B','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-B','ActivePower',num2str(activeB(29,29)));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-B','InductivePower',num2str(reactiveB(29,29)));

set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-C','NominalVoltage',num2str(Ustation));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-C','ActivePower',num2str(activeC(29,29)));
set_param('SimulationAG806_808/charge ponctuelle 848 D-PQ-C','InductivePower',num2str(reactiveC(29,29)));

% --> 860
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-A','ActivePower',num2str(activeA(30,30)));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-A','InductivePower',num2str(reactiveA(30,30)));

set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-B','ActivePower',num2str(activeB(30,30)));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-B','InductivePower',num2str(reactiveB(30,30)));

set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-C','ActivePower',num2str(activeC(30,30)));
set_param('SimulationAG806_808/charge ponctuelle 860 Y-PQ-C','InductivePower',num2str(reactiveC(30,30)));

% --> 890
set_param('SimulationAG806_808/charge ponctuelle 890 DI-A','NominalVoltage',num2str(Ustation*0.167068273092370));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-A','ActivePower',num2str(activeA(22,22)));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-A','InductivePower',num2str(reactiveA(22,22)));

set_param('SimulationAG806_808/charge ponctuelle 890 DI-B','NominalVoltage',num2str(Ustation*0.167068273092370));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-B','ActivePower',num2str(activeB(22,22)));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-B','InductivePower',num2str(reactiveB(22,22)));

set_param('SimulationAG806_808/charge ponctuelle 890 DI-C','NominalVoltage',num2str(Ustation*0.167068273092370));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-C','ActivePower',num2str(activeC(22,22)));
set_param('SimulationAG806_808/charge ponctuelle 890 DI-C','InductivePower',num2str(reactiveC(22,22)));

% --> capacitive 844
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-A','CapacitivePower',num2str(Qc844(1, 1)));

set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-B','CapacitivePower',num2str(Qc844(1, 2)));

set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 844 Y-Z-C','CapacitivePower',num2str(Qc844(1, 3)));

% --> capacitive 848
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-A','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-A','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-A','CapacitivePower',num2str(Qc848(1, 1)));

set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-B','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-B','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-B','CapacitivePower',num2str(Qc848(1, 2)));

set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-C','NominalVoltage',num2str(Vstation));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-C','NominalFrequency',num2str(frequence));
set_param('SimulationAG806_808/charge ponctuelle capacitive 848 Y-Z-C','CapacitivePower',num2str(Qc848(1, 3)));

%% --> Lignes de transmission
set_param('SimulationAG806_808/ligne 800-802','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 800-802','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 800-802','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 800-802','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 800-802','Length',num2str(Ltot_800_802));

set_param('SimulationAG806_808/ligne 802-806','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 802-806','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 802-806','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 802-806','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 802-806','Length',num2str(Ltot_802_806));

set_param('SimulationAG806_808/ligne 806-808(1)','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 806-808(1)','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 806-808(1)','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 806-808(1)','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 806-808(1)','Length',num2str(disdef));

set_param('SimulationAG806_808/ligne 806-808(2)','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 806-808(2)','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 806-808(2)','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 806-808(2)','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 806-808(2)','Length',num2str(Ltot_806_808-disdef));

set_param('SimulationAG806_808/ligne 808-810','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 808-810','Resistance',mat2str(R_303));
set_param('SimulationAG806_808/ligne 808-810','Inductance',mat2str(L_303));
set_param('SimulationAG806_808/ligne 808-810','Capacitance',mat2str(C_303));
set_param('SimulationAG806_808/ligne 808-810','Length',num2str(Ltot_808_810));

set_param('SimulationAG806_808/ligne 808-812','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 808-812','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 808-812','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 808-812','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 808-812','Length',num2str(Ltot_808_812));

set_param('SimulationAG806_808/ligne 812-814','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 812-814','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 812-814','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 812-814','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 812-814','Length',num2str(Ltot_812_814));

set_param('SimulationAG806_808/ligne 814-850','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 814-850','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 814-850','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 814-850','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 814-850','Length',num2str(Ltot_814_850));

set_param('SimulationAG806_808/ligne 816-818','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 816-818','Resistance',mat2str(R_302));
set_param('SimulationAG806_808/ligne 816-818','Inductance',mat2str(L_302));
set_param('SimulationAG806_808/ligne 816-818','Capacitance',mat2str(C_302));
set_param('SimulationAG806_808/ligne 816-818','Length',num2str(Ltot_816_818));

set_param('SimulationAG806_808/ligne 816-824','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 816-824','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 816-824','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 816-824','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 816-824','Length',num2str(Ltot_816_824));

set_param('SimulationAG806_808/ligne 818-820','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 818-820','Resistance',mat2str(R_302));
set_param('SimulationAG806_808/ligne 818-820','Inductance',mat2str(L_302));
set_param('SimulationAG806_808/ligne 818-820','Capacitance',mat2str(C_302));
set_param('SimulationAG806_808/ligne 818-820','Length',num2str(Ltot_818_820));

set_param('SimulationAG806_808/ligne 820-822','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 820-822','Resistance',mat2str(R_302));
set_param('SimulationAG806_808/ligne 820-822','Inductance',mat2str(L_302));
set_param('SimulationAG806_808/ligne 820-822','Capacitance',mat2str(C_302));
set_param('SimulationAG806_808/ligne 820-822','Length',num2str(Ltot_820_822));

set_param('SimulationAG806_808/ligne 824-826','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 824-826','Resistance',mat2str(R_303));
set_param('SimulationAG806_808/ligne 824-826','Inductance',mat2str(L_303));
set_param('SimulationAG806_808/ligne 824-826','Capacitance',mat2str(C_303));
set_param('SimulationAG806_808/ligne 824-826','Length',num2str(Ltot_824_826));

set_param('SimulationAG806_808/ligne 824-828','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 824-828','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 824-828','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 824-828','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 824-828','Length',num2str(Ltot_824_828));

set_param('SimulationAG806_808/ligne 828-830','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 828-830','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 828-830','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 828-830','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 828-830','Length',num2str(Ltot_828_830));

set_param('SimulationAG806_808/ligne 830-854','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 830-854','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 830-854','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 830-854','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 830-854','Length',num2str(Ltot_830_854));

set_param('SimulationAG806_808/ligne 832-858','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 832-858','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 832-858','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 832-858','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 832-858','Length',num2str(Ltot_832_858));

set_param('SimulationAG806_808/ligne 834-842','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 834-842','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 834-842','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 834-842','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 834-842','Length',num2str(Ltot_834_842));

set_param('SimulationAG806_808/ligne 834-860','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 834-860','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 834-860','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 834-860','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 834-860','Length',num2str(Ltot_834_860));

set_param('SimulationAG806_808/ligne 836-840','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 836-840','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 836-840','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 836-840','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 836-840','Length',num2str(Ltot_836_840));

set_param('SimulationAG806_808/ligne 836-862','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 836-862','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 836-862','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 836-862','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 836-862','Length',num2str(Ltot_836_862));

set_param('SimulationAG806_808/ligne 842-844','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 842-844','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 842-844','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 842-844','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 842-844','Length',num2str(Ltot_842_844));

set_param('SimulationAG806_808/ligne 844-846','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 844-846','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 844-846','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 844-846','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 844-846','Length',num2str(Ltot_844_846));

set_param('SimulationAG806_808/ligne 846-848','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 846-848','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 846-848','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 846-848','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 846-848','Length',num2str(Ltot_844_846));

set_param('SimulationAG806_808/ligne 850-816','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 850-816','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 850-816','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 850-816','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 850-816','Length',num2str(Ltot_850_816));

set_param('SimulationAG806_808/ligne 852-832','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 852-832','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 852-832','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 852-832','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 852-832','Length',num2str(Ltot_852_832));

set_param('SimulationAG806_808/ligne 854-852','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 854-852','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 854-852','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 854-852','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 854-852','Length',num2str(Ltot_854_852));

set_param('SimulationAG806_808/ligne 854-856','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 854-856','Resistance',mat2str(R_303));
set_param('SimulationAG806_808/ligne 854-856','Inductance',mat2str(L_303));
set_param('SimulationAG806_808/ligne 854-856','Capacitance',mat2str(C_303));
set_param('SimulationAG806_808/ligne 854-856','Length',num2str(Ltot_854_856));

set_param('SimulationAG806_808/ligne 858-834','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 858-834','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 858-834','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 858-834','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 858-834','Length',num2str(Ltot_858_834));

set_param('SimulationAG806_808/ligne 858-864','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 858-864','Resistance',mat2str(R_302));
set_param('SimulationAG806_808/ligne 858-864','Inductance',mat2str(L_302));
set_param('SimulationAG806_808/ligne 858-864','Capacitance',mat2str(C_302));
set_param('SimulationAG806_808/ligne 858-864','Length',num2str(Ltot_858_864));

set_param('SimulationAG806_808/ligne 860-836','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 860-836','Resistance',mat2str(R_301));
set_param('SimulationAG806_808/ligne 860-836','Inductance',mat2str(L_301));
set_param('SimulationAG806_808/ligne 860-836','Capacitance',mat2str(C_301));
set_param('SimulationAG806_808/ligne 860-836','Length',num2str(Ltot_860_836));

set_param('SimulationAG806_808/ligne 862-838','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 862-838','Resistance',mat2str(R_304));
set_param('SimulationAG806_808/ligne 862-838','Inductance',mat2str(L_304));
set_param('SimulationAG806_808/ligne 862-838','Capacitance',mat2str(C_304));
set_param('SimulationAG806_808/ligne 862-838','Length',num2str(Ltot_862_838));

set_param('SimulationAG806_808/ligne 888-890','Frequency',num2str(frequence));
set_param('SimulationAG806_808/ligne 888-890','Resistance',mat2str(R_300));
set_param('SimulationAG806_808/ligne 888-890','Inductance',mat2str(L_300));
set_param('SimulationAG806_808/ligne 888-890','Capacitance',mat2str(C_300));
set_param('SimulationAG806_808/ligne 888-890','Length',num2str(Ltot_888_890));

set_param('SimulationAG806_808/powergui','frequency',num2str(frequence));

sim('SimulationAG806_808'); % ---> changer


