function Results_To_Excel
%
%
% 10.10 Project. Spring 2011.
% Prepared by Jennifer Hsu
%
% This function prints results of the simulation and economic
% results for the whole process.
%
%   INPUT Global Variables
global FigureNumber
global ReactorHeater ReactionHeatingPeriod AmountSolvent_S2
global Reactor_feed Reactor_effluent
global ReactorTimeVector Reactor_dynamics Reactor_effluent
global Solvent_S2 Extractor_Phase_1_exit_stream Extractor_Phase_2_exit_stream
global Materials_Costs Utilities_Costs Vessel_Rental_Costs Labor_Costs Materials_Credits
global Materials_Prices Materials_Properties
global Crystal_phase_Coating_Liquid_from_crystallizer Crystal_phase_from_crystallizer Liquid_phase_from_crystallizer
global Distillation_overhead_product Distillation_bottoms_product
global Vessel_Occupancy
global Total_Materials_Cost Total_Utilities_Cost Total_Labor_Cost Total_Rental_Costs Total_Operating_Cost
global Total_Materials_Credits Net_Operating_Cost Cost_per_Kilogram_of_Product Profit_per_Kilogram_of_Product
global Vapor_stream_from_dryer Crystal_stream_from_dryer
global Number_of_batches_per_year Annual_Materials_Cost Annual_Utilities_Cost Annual_Labor_Cost Annual_Rental_Cost
global Annual_Net_Operating_Cost Annual_Production Annual_Income Annual_Profit


filename = 'data.xls';

line = {ReactorHeater; ReactionHeatingPeriod; AmountSolvent_S2};
xlswrite(filename, line, 1, 'B2');

line = [Reactor_feed(1:10)];
xlswrite(filename, line, 1, 'B9');
line = [Reactor_effluent(1:10)];
xlswrite(filename, line, 1, 'B10');
line = Solvent_S2(1:10)';
xlswrite(filename, line, 1, 'B12');
line = [Extractor_Phase_1_exit_stream(1:10)];
xlswrite(filename, line, 1, 'B13');
line = [Extractor_Phase_2_exit_stream(1:10)];
xlswrite(filename, line, 1, 'B14');
line = [Distillation_overhead_product(1:10); Distillation_bottoms_product(1:10)];
xlswrite(filename, line, 1, 'B16');
line = [Crystal_phase_from_crystallizer(1:10); Crystal_phase_Coating_Liquid_from_crystallizer(1:10); Liquid_phase_from_crystallizer(1:10)];
xlswrite(filename, line, 1, 'B19');
line = [Crystal_stream_from_dryer(1:10); Vapor_stream_from_dryer(1:10)];
xlswrite(filename, line, 1, 'B23');

line = [(Reactor_feed(1)- Distillation_overhead_product(1))*Materials_Properties(1,1)/1000; ...
        (Reactor_feed(2)- Distillation_overhead_product(2))*Materials_Properties(2,1)/1000; ...
        Reactor_feed(7)*Materials_Properties(7,1)/1000; ...
        Reactor_feed(8)*Materials_Properties(8,1)/1000; ...
        ((Solvent_S2(9)- Distillation_bottoms_product(9))*Materials_Properties(9,1))/1000];
xlswrite(filename, line, 1, 'B27');

line = [Crystal_phase_from_crystallizer(3)*Materials_Properties(3,1)/1000];
xlswrite(filename, line, 1, 'B33');

line = Materials_Costs(1,1:4)';
xlswrite(filename, line, 1, 'B38');
line = zeros(4,5);
xlswrite(filename, line, 1, 'C38');
line = [Materials_Costs(2,5),0,0,0,0,0];
xlswrite(filename, line, 1, 'B42');
line = zeros(1,4);
xlswrite(filename, line, 1, 'C42');
line = [Total_Materials_Cost];
xlswrite(filename, line, 1, 'B43');

line = Utilities_Costs((1:6),(1:7))';
xlswrite(filename, line, 1, 'B46');
line = [Total_Utilities_Cost];
xlswrite(filename, line, 1, 'B53');

line = Labor_Costs(1:6);
xlswrite(filename, line, 1, 'B56');
line = [Total_Labor_Cost];
xlswrite(filename, line, 1, 'B57');

line = Vessel_Rental_Costs(1:6);
xlswrite(filename, line, 1, 'B60');
line = [Total_Rental_Costs];
xlswrite(filename, line, 1, 'B61');

line = [Total_Operating_Cost];
xlswrite(filename, line, 1, 'B63');

line = [0, 0, Materials_Credits(3,1), 0, 0, 0];
xlswrite(filename, line, 1, 'B66');
line = [0, 0, Materials_Credits(3,2), 0, 0, 0];
xlswrite(filename, line, 1, 'B67');
line = [0, 0, Materials_Credits(3,5), 0, 0, 0];
xlswrite(filename, line, 1, 'B68');

line = [Total_Materials_Credits];
xlswrite(filename, line, 1, 'B69');
line = [Net_Operating_Cost];
xlswrite(filename, line, 1, 'B71');
line = [Cost_per_Kilogram_of_Product];
xlswrite(filename, line, 1, 'B72');
line = [Profit_per_Kilogram_of_Product];
xlswrite(filename, line, 1, 'B73');

line = [Number_of_batches_per_year];
xlswrite(filename, line, 1, 'B76');
line = [Annual_Production];
xlswrite(filename, line, 1, 'B77');
line = [Annual_Materials_Cost];
xlswrite(filename, line, 1, 'B78');
line = [Annual_Utilities_Cost];
xlswrite(filename, line, 1, 'B79');
line = [Annual_Labor_Cost];
xlswrite(filename, line, 1, 'B80');
line = [Annual_Rental_Cost];
xlswrite(filename, line, 1, 'B81');
line = [Annual_Net_Operating_Cost];
xlswrite(filename, line, 1, 'B82');
line = [Annual_Income];
xlswrite(filename, line, 1, 'B83');
line = [Annual_Profit];
xlswrite(filename, line, 1, 'B84');

end