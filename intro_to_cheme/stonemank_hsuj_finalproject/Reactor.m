function Reactor
% 
% 10.10 Project. Spring 2011.
% 
% Prepared by George Stephanopoulos
% Updated by: Kristie Stoneman, 04/08/2011
% Updated by: Jennifer Hsu, 04/20/2011
%
% This function simulates the performance of the Batch Reactor and computes
% its associated economics. It is called by the function "Simulator.m".
%
% INPUT Global Variables
global ReactionHeatingPeriod ReactorHeater
global Reactor_feed
global TimeReactorCool ReactorCoolTemp ReactorTurn ReactorCool ReactorStir
global Reactor_rental_cost_per_hour Electricity_cost Water_cooling_cost
global Labor_unit_cost
global Materials_Prices
global Materials_Properties
%
% OUTPUT Global Variables
%
global ReactorTimeVector Reactor_dynamics Reactor_effluent
global Materials_Costs Utilities_Costs Vessel_Rental_Costs Labor_Costs Material_Credits
global Vessel_Occupancy
% 
% Set initial reactor parameters
% 
X = ReactionHeatingPeriod;          % Sets the value of the reactor heating period
% Y = [molesA, molesB, molesP, moles Q, molesW, molesZ, molesC, molesS1, molesS2, T_Reactor, total kg/moles(?), total volume]
Y0 = Reactor_feed;          % Sets the initial conditions to be equal to the conditions of the Reactor Feed
P = [1; -1];                % The P(1)>0, P(2)<0 imply that heating is ON and cooling is OFF for the integrator
TimeSpanHeat = [0 X];       % Set range of integration from 0 until the heater is turned off
%
% Period-1 of integration
% Solve dynamic balance equations for the Bath Reactor (see equations in
% file, Reactions.m) keeping the reactor heater ON and the reactor cooler
% OFF.
%
[TimeVecHeat Y1] = ode45(@Reactions,TimeSpanHeat,Y0,[],P); % integrate
%
% Turn off the heater and turn on the cooler
P = [-1; 1];                % The P(1)<0, P(2)>0 imply that heating is OFF and cooling is ON for the integrator
%
% Period-2 of integration
% Solve dynamic balance equations for the Batch Reactor (see equations in
% file, Reactions.m) keeping the reactor heater OFF and the reactor cooler
% ON.
% 
% Set the start and the end time-points of cooling
TimeVecHeatLength = length(TimeVecHeat);  % Determine the length of the time vector
TimeSpanCool = [X X+TimeReactorCool];  % Set the start and stop times of the cooling
% Set the initial conditions for the Period-2 to be the same as the final
% conditions of Period 1:
Y0 = Y1(TimeVecHeatLength,:);
Y0 = Y0';
% Set conditions for ending integration when the temperature of the
% reactor's content has reached ReactorCoolTemp
OPTIONS = odeset('Events',@ReactorEvents);  % set for events to stop at ReactorCoolTemp
%
[TimeVecCool Y2] = ode45(@Reactions,TimeSpanCool,Y0,OPTIONS,P); % Integrate and use OPTIONS to stop integration
%
% Collate the solutions of integration in Period-1 and Period-2
ReactorTimeVector = [TimeVecHeat; TimeVecCool];    % Form a single time vector of reactor heating and cooling
Y = [Y1; Y2]; % Form a single Y vector containing the molar amounts at times corresponding to tvec vector
% 
% Assign values to the vector, ReactorEffluent. These values will become
% available to other processing units, e.g. Batch Extractor, through a
% GLOBAL assignment.
% 
TimeVecCoolLength = length(TimeVecCool); % Determine the length of the time vector from the integration
k = length(ReactorTimeVector);
% !!!!
% plot(ReactorTimeVector, Y(:,10)); 
%
% Put the results of the dynamic simulation of the batch reactor into one
% variable, "reactor_effluent" and make it globally available.
Reactor_dynamics = Y;
Reactor_effluent = Reactor_dynamics(k,:);
% 
% Compute the Economics of the Reactor per batch.
% 
reaction_period = ReactorTimeVector(k)/3600;                            % in hours
reactor_rental_cost = (reaction_period+ReactorTurn)*Reactor_rental_cost_per_hour;     % in $
amount_of_heat_used = TimeVecHeat(length(TimeVecHeat))*ReactorHeater;   % in KW
reactor_heating_cost = amount_of_heat_used/3600*Electricity_cost;  % in $
amount_of_cooling_used = (ReactorCool*(Y1(TimeVecHeatLength,10) - Y2(TimeVecCoolLength,10)))*TimeReactorCool;  % in KJ
reactor_cooling_cost = Water_cooling_cost*amount_of_cooling_used;       % in $
reactor_stirrer_electricity_cost = ReactorTimeVector(k)/3600*ReactorStir*Electricity_cost;           % in $
% 
% Materials Cost, in $
reagent_materials_cost_A = Reactor_feed(1)*Materials_Prices(1)/1000*Materials_Properties(1,1);
reagent_materials_cost_B = Reactor_feed(2)*Materials_Prices(2)/1000*Materials_Properties(2,1);
catalyst_cost_C = Reactor_feed(7)*Materials_Prices(7)/1000*Materials_Properties(7,1);
solvent_cost_S1 = Reactor_feed(8)*Materials_Prices(8)/1000*Materials_Properties(8,1);
%
product_value_from_P = Reactor_effluent(3)*(Materials_Properties(3,1)/1000)*Materials_Prices(3);
product_value_from_Q = Reactor_effluent(4)*(Materials_Properties(4,1)/1000)*Materials_Prices(4);
product_value_from_W = Reactor_effluent(5)*(Materials_Properties(5,1)/1000)*Materials_Prices(5);
product_value_from_Z = Reactor_effluent(6)*(Materials_Properties(6,1)/1000)*Materials_Prices(6);
%
% Labor Cost
reactor_labor_cost = Labor_unit_cost*(reaction_period + ReactorTurn); % in $
% 
% SUMMARY OF REACTOR ECONOMICS
% 
Materials_Costs(1,1) = reagent_materials_cost_A;
Materials_Costs(1,2) = reagent_materials_cost_B;
Materials_Costs(1,3) = catalyst_cost_C;
Materials_Costs(1,4) = solvent_cost_S1;
Materials_Costs(1,5) = 0; % Cost of Solvent S2 (zero, because it is not present)
Utilities_Costs(1,1) = reactor_heating_cost;
Utilities_Costs(1,2) = reactor_stirrer_electricity_cost;
Utilities_Costs(1,3) = reactor_cooling_cost;
Utilities_Costs(1,(4:7)) = 0; % No steam heating, refrigeration cooling, fuel heating, or waste treatment
Vessel_Rental_Costs(1) = reactor_rental_cost;
Labor_Costs(1) = reactor_labor_cost;
Material_Credits(1,(1:5)) = 0;
Vessel_Occupancy(1) = reaction_period + ReactorTurn; % Total occupancy time of the reactor vessel, per batch

end