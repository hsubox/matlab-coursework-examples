function [residual] = residuals(parameters)
%
% This function computes the residuals of the model fit of the kinetic data
% for the data of Reaction-1, and returns this value to the lsqnonlin
% calling function.
% 
% INPUT
%   parameters: a vector of the guessed values for the pre-exponential
%   factor and activation energy
% OUTPUT
%   residual: a vector with the values of the residuals:
%   ((model-rate)-(rate from experiment-i))
pre_exponential = parameters(1); % (cm3)^2/(s (mol)^2)
activation = parameters(2); % J/mol
reactor_volume = 10320; % volume of experimental reactor, in cm3
%
% Experimental Data for Reaction-1
% Input flow of A in moles.
A0 = [1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0];
% Input flow of B in moles.
B0 = [2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0; 2.0];
% Output flow of A in moles.
AF = [.930; .921; .912; .903; .893; .883; .872; .863; .853; .842; .833; .823; .813];
% Output flow of B in moles.
BF = [1.860; 1.842; 1.824; 1.806; 1.786; 1.766; 1.744; 1.726; 1.706; 1.684; 1.666; 1.646; 1.626];
% Reaction temperatures at which the above data were collected
temp = [300; 310; 320; 330; 340; 350; 360; 370; 380; 390; 400; 410; 420];
% The time duration for each of the 13 experiments is given by the
% following vector
time = [103.2; 102.5; 101.2; 100.2; 99.8; 98.7; 96.3; 95.1; 94.3; 92.9; 90.7; 88.4; 85.1];
% Create a vector of the 13 experimental estimates of rates, for 13
% experiments: Rate in (mol/second)
rate_exp = (A0 - AF)./(time);
% Create a vector of 13 modeled rates, for the 13 experiments
% Create the Arrhenius term: (Pre-Exponential)*exp(-Activation Energy/RT)
arrhenius = (pre_exponential).*exp((-activation)./(8.314.*temp));
% Average concentration in the reactor of A and B.
conc_A = ((A0 + AF)/2)/(reactor_volume);
conc_B = ((B0 + BF)/2)/(reactor_volume);
%
rate_model = arrhenius.*conc_A.*(conc_B.^2).*reactor_volume;
% 
% Create a vector of the 13 residuals
residual = rate_exp - rate_model;
end