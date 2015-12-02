function F = Simulator(X)
%
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopoulos.
% Transcribed by Kristie Stoneman
% Updated by: Jennifer Hsu, 04/28/2011
%
% This function directs the sequential simulation of the processing units
% in the process.
%
%   INPUT:
%       X ----  Vector of Optimization Variables
%               X(1) = ReactorHeater
%               X(2) = ReactionHeatingPeriod
%               X(3) = AmountSolvent_S2
%   OUTPUT: Global Variable
global ReactorHeater ReactionHeatingPeriod AmountSolvent_S2
%   OUTPUT:
%       F ----  The value of the Net Operating Profit
%
ReactorHeater = X(1);
ReactionHeatingPeriod = X(2);
AmountSolvent_S2 = X(3);
%
%.............. STEP-2(A)-1:  Simulate Batch Reactor
Reactor;
%
%.............. STEP-2(A)-2:  Simulate the Batch Extractor
Extractor;
%
%.............. STEP-2(A)-3:  Simulate the Batch Distiallation
Distillation;
%
%.............. STEP-2(A)-4:  Simulate the Batch Crystallizer
Crystallizer;
%
%.............. STEP-2(A)-5:  Simulate the Batch Dryer
Dryer;
%
%.............. STEP-2(A)-6:  Simulate the Waste Treatment Unit
Waste_Treatment;
%
%.............. STEP-2(A)-7:  Compute Process Economics
F = Overall_Process_Economic_Objective(X);
%
end
