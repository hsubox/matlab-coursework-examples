 function [parameters] = KineticsRegression
% 
% determines the Arrhenius paraters for A + 2B = P
% parameters(1) = Arrhenius pre-exponential factor A, in cm6/mole2-sec
% parameters(2) = E_act, in J/mol
% 
% Prepared by George Stephanopoulos
% Modified by Jennifer Hsu
% Modified: 4/13/2011
%
% This function regresses a set of experimental data for Reaction(1) (the
% main reaction) of the process and computes the Least Squares estimate of
% the (a) Pre-Exponential factor, and (b) Activation Energy of the
% reaction.
%
% OUTPUT
%   Parameters = [Pre-exponential factor    Activation energy] for
%   Reaction-1
%
% Initial guesses
parameters_0(1) = 2000; % Initial guess of the pre-exponential factor of the main reaction
parameters_0(2) = 12000; % Initial guess of the activation energy of the main reaction
% Call the MatLab function that carries out Non-Linear Least Squares
% estimates
[parameters, resnorm] = lsqnonlin(@residuals, parameters_0, [1;2000], [1e8; 40000], [optimset('Display','iter','TolFun', 1e-30)]);
end