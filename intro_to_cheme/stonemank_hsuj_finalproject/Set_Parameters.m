function Set_Parameters
% 
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopoulos.
% 
% This function calls several other functions, which activate the
% assignment of values to the parameters associated with various components
% of the project. Each of these other functions put the saved values in the
% corresponding parameters of the project and makes them available to
% whatever function needs them through the appropriate GLOBAL
% characterization of the parameters.
%
% INPUT Global Variables. None.
% OUTPUT Global Variables. None.
%
% STEP-1(A): Set the Physical Properties values for all materials in the
% project.
MaterialsProperties;
%
% STEP-1(B): Set the values for all properties of the three chemical
% reactions in the project.
%
ReactionsProperties;
%
% STEP-1(C): Set the values for the various characteristics of all the
% processing unites in the process of the project.
%
ProcessUnitsParameters;
%
% STEP-1(D): Set economic parameters
%
EconomicData;
%
% STEP-1(E): Set the characteristics of the feed to the reactor.
%
ReactorFeed;

global Materials_Properties
global Reactions_Properties
global ExtractorTurn
global Distillation_rental_cost_per_hour
global Reactor_feed

% To test if global variables are set:
% fprintf('Materials_Properties(2,2) = %d\n', Materials_Properties(2,2));
% fprintf('Reactions_Properties(3,1) = %d\n', Reactions_Properties(3,1));
% fprintf('ExtractorTurn = %d\n', ExtractorTurn);
% fprintf('Distillation_rental_cost_per_hour = %d\n', Distillation_rental_cost_per_hour);
% fprintf('Reactor_feed(10) = %d\n', Reactor_feed(10));

end