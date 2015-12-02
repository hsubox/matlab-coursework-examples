% Project_OLED_Dyes
%
%
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopoulos.
%
% This function represents the top-level routine of the entire program.
% Here is where the problem-solving procedure starts. This routine carrier
% out the following sequence of tasks:
% (a) Triggers the setting of the parameters for the materials, reactions,
% processing units, and varioius economic parameters.
% (b) Determines whether it will proceed to carry out simple simulation for
% given values of the optimization variables, or automatic optimization.
% (c) Calls the optimization variables or directs simple simulation.
% (d) Displays the results of simulation or optimization.
%
% INPUTS. It has none, since it is the top-level routine.
% OUTPUTS. This routine in itself has no output. All the variouis outputs
% are created by other routines, whose execution it has triggered.
global FigureNumber
% global ReactorHeater ReactionHeatingPeriod AmountSolvent_S2
% These are three optimization variables.
%
%
% STEP-1: SET THE VALUES OF THE PROJECT'S PARAMETERS
%
FigureNumber = 0;
Set_Parameters;
% The SET_PARAMETERS is the function, whose "responsibility" is to assign
% values to the process parameters.
%
% STEP-2: SET THE TYPE OF PROBLEM TO BE SOLVED: SIMULATION, OR OPTIMIZATION
% ??
%
% What do you want to do ?
%   (a) Simulation of the process with user-specified values for the
%   optimization variables, or
%   (b) Automatic optimization
%
disp('  ');
disp('  ');
decision = input('For interactive simulation type, 1. For automatic optimization type, 2. So, 1 or 2 ??');
switch decision
    case 1
        % STEP-2(A) SIMULATE THE ENTIRE PROCESS
        disp('  ');
        disp('  ');
        %
        % Set the values of the optimization variables, which will be used
        % by the simulator.
        ReactorHeater = input('Enter output of Reactor Heater (in kW). Suggested value: 500. Reactor Heater Output = ');
        disp('  ');
        ReactionHeatingPeriod = input('Enter Reactor Heating period (in seconds). Suggested value: 1500 seconds. Reactor heating period = ');
        disp('  ');
        AmountSolvent_S2 = input('Enter volume of extraction solvent. S2 (in m3). Suggested value: 3.5 m3. Volume of Solvent, S2 = ');
        disp('  ');
        disp('  ');
        disp('  ');
        % 
        % Call the Simulator.
        % The function, "Simulator.m" takes the responsibilty to oganize
        % the flow of information and the sequencing of computation.
        X(1) = ReactorHeater;
        X(2) = ReactionHeatingPeriod;
        X(3) = AmountSolvent_S2;
        Simulator(X);
        % The SIMULATOR is the function, whose "responsibility" is to carry
        % out the process simulation.
        %
        % F = Overall_Process_Economic_Objective(X); % Compute the
        % economics associated with Process
        %
    case 2
        % STEP-2(B) OPTIMIZE THE ENTIRE PROCESS
        %
        % STEP-2(B)-1: Set initial values for the automatic search for the
        % optimum values of the optimization variables.
        %
        ReactorHeater = 100;            % Sets the values of the reactor heater output in kW.
        ReationHeatingPeriod = 1000;    % How long is the reactor heater ON, in seconds.
        AmountSolvent_S2 = 3;           % Used in the batch extractor, in m3.
        Optimization_Variables_Initial_Values = [ReactorHeater; ReactionHeatingPeriod; AmountSolvent_S2];
        %
        % STEP-2(B)-2: Search for the optimum values of: (a) Reactor heater
        %              output, (b)
        %              Period of heating the reactor, (c) Amount of
        %              extraction Solvent, S2.
        % 
        options = optimset('Display','iter'); % This OPTION displays the value of the Objective Function at each iteration.
        [Variables, Objective] = fminsearch(@Simulator, Optimization_Variables_Initial_Values, options);
        % The FMINSEARCH is the MatLab function, whose "responsibility" is
        % to carry out the optimization.
        % The SIMULATOR is the function, whose responsibility is to provide
        % an evaluation of the Objective-Function, i.e. of the "Annual
        % Profit", for given values of the optimization variables.
        %
    otherwise % This case is introduced here in order to account for a 
              % mis-typing, i.e. when the user input is different than 1 or
              % 2.
        disp('  ');
        disp('  ');
        error('WARNING: You have entered a response different than 1 or 2. Start again');
        disp('  ');
        disp('  ');
        abort;
end
%
% STEP-3: DISPLAY SIMULATION or OPTIMIZATION RESULTS
%
Results_Displayer;
% The RESULTS_DISPLAYER is the function, whose "responsibility" is to
% display the results.