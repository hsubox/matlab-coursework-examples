function ProcessUnitsParameters
% 
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopoulos.
% 
% This function sets the parametric values for the various processing units
% in the process of the project. Makes these values available to other
% MATLAB functions through the command, GLOBAL.
%
% INPUT Global Variables
% OUTPUT Global Variables
global ReactorVolume ReactorStir ReactorCool ReactorTurn ReactorCoolTemp TimeReactorCool
global ExtractorVolume ExtractorTurn ExtractorStir
global DistillationTurn DistillationVolume
global CrystallizerVolume CrystallizationStir CrystallizationTurn CrystallizerCool
global DryerTurn DryerHeatingPower
%
% Set the parametric values for the Batch Reactor
%
ReactorVolume = 2;          % Reactor filling volume in cubic meters (m3)
ReactorStir = 5;            % Reactor stirring power, KW
ReactorCool = 20;           % Reactor water cooling heat transter coefficient, KW/(degree C)
ReactorTurn = 3;            % Reactor turn around time, hr
ReactorCoolTemp = 25;       % Temperature to which the reactor is to be cooled at the end of the batch
TimeReactorCool = 2000;     % Time that the reactor cooling is on, seconds
%
% Set the parametric values for the Batch Extractor
%
ExtractorVolume = 6;        % Extractor filling volume in cubic meters (m3)
ExtractorTurn = 2;          % Extractor turn around time, in hours.
ExtractorStir = 5;          % Extractor stirring power, KW
%
% Set the parametric values for the Batch Distillation system
%
DistillationVolume = 6;     % Distillation volume in cubic maters (m3)
DistillationTurn = 3;       % Distillation turn around time, in hours
%
% Set the parametric values for the Batch Crystallizer
%
CrystallizerVolume = 4;     % Volume of the crystallization vessel, in cubic meters (m3)
CrystallizationStir = 3;    % Crystallization vessel stirring power, KW
CrystallizationTurn = 2;    % Crystallizer's turn around time, in hours
CrystallizerCool = 10;      % Capacity of the refrigeration-based cooling, KW
%
% Set the parametric values for the Batch Dryer
%
DryerTurn = 2;              % Dryer's turn around time, in hours
DryerHeatingPower = 1.5;    % Heating power of the dryer, in KW
%
% No parameters for the waste treatment system
%
end