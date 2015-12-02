function Results_Displayer
%
%
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopolous.
% Transcribed by Kristie Stoneman.
% Updated by: Jennifer Hsu, 04/28/2011
%
% This function organizes the display of the simulation and economic
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
%
disp('     ');
disp('     ');
disp('     ');
%
%   STEP-3(A):  DISPLAY THE VALUES OF THE OPTIMIZATION VARIABLE
%
disp('VALUES OF THE OPTIMIZATION VARIABLES');
fprintf(' Reactor Heater Output (KW/hr)         =   %f\n', ReactorHeater);
fprintf(' Reactor Heating period (seconds)      =   %f\n', ReactionHeatingPeriod);
fprintf(' Amount of Extraction Solvent, S1 (m3) =   %f\n\n\n', AmountSolvent_S2);
%   STEP-3(B):  DISPLAY THE PROCESS INFORMATION FOR A SINGLE BATCH OF
%               PRODUCTION.
%
disp('TABLE OF PROCESS STREAMS PER BATCH OF PRODUCTION');
disp('     ');
disp(['Process Stream             Moles, A      Moles, B      Moles, P      Moles, Q      Moles, W      Moles, Z      Moles, C       Moles, S1     Moles, S2    Temperature']);
disp('--------------------------------------------------------------------------------------------------------------------------------------------------------------------');
fprintf('Reactor \n');
fprintf('      Feed                 %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n', Reactor_feed(1:10));
fprintf('      Effluent             %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n', Reactor_effluent(1:10));
fprintf('Extractor \n');
fprintf('      Fresh Solvent, S2    %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n', Solvent_S2(1:10));
fprintf('      Solvent, S1-Phase    %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n', Extractor_Phase_1_exit_stream(1:10));
fprintf('      Solvent, S2-Phase    %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n', Extractor_Phase_2_exit_stream(1:10));
fprintf('Distillation \n');
fprintf('      Overhead             %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n', Distillation_overhead_product(1:10));
fprintf('      Bottoms              %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n', Distillation_bottoms_product(1:10));
fprintf('Crystallizer \n');
fprintf('      Crystal-Phase, Solid %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n', Crystal_phase_from_crystallizer(1:10));
fprintf('      Crystal-Phase, Liquid%8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n', Crystal_phase_Coating_Liquid_from_crystallizer(1:10));
fprintf('      Liquid-Phase         %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n', Liquid_phase_from_crystallizer(1:10));
fprintf('Dryer \n');
fprintf('      Crystal-Phase(pure)  %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n', Crystal_stream_from_dryer(1:10));
fprintf('      Vapor-Phase          %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n', Vapor_stream_from_dryer(1:10));
%
disp('     ');
disp('NET UTILIZATION OF MATERIALS PER BATCH (Fresh Materials - Reclaimed Materials) ');
disp('     ');
fprintf('  Reagent, A (Kgs)  = %7.2f\n', (Reactor_feed(1)- Distillation_overhead_product(1))*Materials_Properties(1,1)/1000 );
fprintf('  Reagent, B (Kgs)  = %7.2f\n', (Reactor_feed(2)- Distillation_overhead_product(2))*Materials_Properties(2,1)/1000 );
fprintf('  Catalyst, C (Kgs) = %7.2f\n', Reactor_feed(7)*Materials_Properties(7,1)/1000 );
fprintf('  Solvent, S1 (Kgs) = %7.2f\n', Reactor_feed(8)*Materials_Properties(8,1)/1000 );
fprintf('  Solvent, S2 (Kgs) = %7.2f\n\n\n',((Solvent_S2(9)- Distillation_bottoms_product(9))*Materials_Properties(9,1))/1000); % added "(" before Solvent_S2(9)
disp('AMOUNT OF PRODUCT');
disp('     ')
fprintf('  P, (Kilograms per Batch) = %5.2f \n\n\n\n ', Crystal_phase_from_crystallizer(3)*Materials_Properties(3,1)/1000);
%
%   STEP-3(C):  DISPLAY THE RESULTS OF PROCESS ECONOMICS PER BATCH.
%
disp('TABLE OF PROCESS ECONOMICS PER BATCH')
disp('     ');
disp('     ');
disp(['                        Reactor      Extractor     Distillation     Crystallization      Dryer     Waste Treatment']);
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('MATERIALS COSTS PER BATCH ( $ ) \n');
fprintf('  Reagent, A           %7.2f       %7.2f         %6.2f            %6.2f           %6.2f        %6.5f\n', Materials_Costs(1,1), 0, 0, 0, 0, 0);
fprintf('  Reagent, B           %7.2f       %7.2f         %6.2f            %6.2f           %6.2f        %6.5f\n', Materials_Costs(1,2), 0, 0, 0, 0, 0);
fprintf('  Catalyst, C          %7.2f       %7.2f         %6.2f            %6.2f           %6.2f        %6.5f\n', Materials_Costs(1,3), 0, 0, 0, 0, 0);
fprintf('  Solvent, S1          %7.2f       %7.2f         %6.2f            %6.2f           %6.2f        %6.5f\n', Materials_Costs(1,4), 0, 0, 0, 0, 0);
fprintf('  Solvent, S2        %9.2f       %7.2f         %6.2f            %6.2f           %6.2f        %6.5f\n', 0, Materials_Costs(2,5), 0, 0, 0, 0);
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('Total Materials Cost ( $ per batch) = %7.2f \n', Total_Materials_Cost);
disp('     ');
disp('     ');
fprintf('UTILITIES COSTS PER BATCH ( $ ) \n');
fprintf('  Electricity-Heat     %7.2f       %7.2f         %6.2f             %6.2f          %6.2f        %6.5f\n',Utilities_Costs((1:6),1));
fprintf('  Electricity-Stir     %7.2f       %7.2f         %6.2f             %6.2f          %6.2f        %6.5f\n',Utilities_Costs((1:6),2));
fprintf('  Water Cooling        %7.2f       %7.2f         %6.2f             %6.2f          %6.2f        %6.5f\n',Utilities_Costs((1:6),3));
fprintf('  Steam Heating        %7.2f       %7.2f       %6.2f             %6.2f          %6.2f        %6.5f\n',Utilities_Costs((1:6),4));
fprintf('  Refridgerant Cooling %7.2f       %7.2f         %6.2f            %6.2f          %6.2f        %6.5f\n',Utilities_Costs((1:6),5));
fprintf('  Fuel Heating-Dryer   %7.2f       %7.2f         %6.2f             %6.2f         %6.2f        %6.5f\n',Utilities_Costs((1:6),6));
fprintf('  Waste Treatment      %7.2f       %7.2f         %6.2f             %6.2f          %6.2f     %6.5f\n\n\n',Utilities_Costs((1:6),7));
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('Total Utilities Cost ( $ per batch) = %7.2f\n',Total_Utilities_Cost);
disp('     ');
disp('     ');
fprintf('LABOR COSTS PER BATCH ( $ ) \n');
fprintf('   Unit Labor Cost     %7.2f       %7.2f         %6.2f             %6.2f         %6.2f       %6.5\n', Labor_Costs(1:6));
disp('     ');
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('Total Labor Cost ( $ per batch) = %7.2f\n', Total_Labor_Cost);
disp('     ');
disp('     ');
fprintf('EQUIPMENT RENTAL COSTS PER BATCH ( $ )  \n');
fprintf(' Vessel Rental Cost   %7.2f      %7.2f       %6.2f           %6.2f            %6.2f%6.5\n', Vessel_Rental_Costs(1:6));
disp('     ');
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('Total Rental Costs ( $ per batch) = %7.2f\n\n\n', Total_Rental_Costs );
fprintf('TOTAL OPERATING COST PER BATCH ( $ ) = %7.2f\n', Total_Operating_Cost);
disp('-------------------------------------------------------------------------------------------------------------------------');
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('MATERIALS CREDITS PER BATCH ( $ ) \n');
fprintf('  Recovered, A         %7.2f       %7.2f        %6.2f              %6.2f         %6.2f         %6.5f\n', 0, 0, Materials_Credits(3,1), 0, 0, 0);
fprintf('  Recovered, B         %7.2f       %7.2f       %6.2f              %6.2f         %6.2f         %6.5f\n', 0, 0, Materials_Credits(3,2), 0, 0, 0);
fprintf('  Recovered, S2        %7.2f       %7.2f         %6.2f              %6.2f         %6.2f         %6.5f\n', 0, 0, Materials_Credits(3,5), 0, 0, 0);
disp('-------------------------------------------------------------------------------------------------------------------------');
fprintf('TOTAL MATERIALS CREDITS PER BATCH ( $ ) = %7.2f \n\n\n', Total_Materials_Credits);
fprintf('NET OPERATING COST PER BATCH ( $ )      = %7.2f \n\n', Net_Operating_Cost);
fprintf('COST PER KILOGRAM, P ( $/Kg)            = %7.2f \n\n', Cost_per_Kilogram_of_Product);
fprintf('PROFIT PER KILOGRAM, P ( $/Kg)          = %7.2f \n\n', Profit_per_Kilogram_of_Product);
%
%   STEP-3(D):  DISPLAY A SUMMARY OF ECONOMICS ON AN ANNUAL BASIS
%
disp('     ');
disp('-------------------------------------------------------------------------------------------------------------------------');
disp('SUMMARY OF PROCESS ECONOMICS ON AN ANNUAL BASIS (In $ for a 4,000 hours Annual Operation)');
disp('     ');
disp('     ');
fprintf('    NUMBER OF BATCHES PER YEAR     =  %4.2f \n\n', Number_of_batches_per_year);
fprintf('    ANNUAL PRODUCTION OF P, Kgs    = %9.2f \n\n', Annual_Production);
fprintf('    MATERIALS COST (Net), $        =  %9.2f \n\n', Annual_Materials_Cost);
fprintf('    UTILITIES COST, $              =  %9.2f \n\n', Annual_Utilities_Cost);
fprintf('    LABOR COST, $                  =  %9.2f \n\n', Annual_Labor_Cost);
fprintf('    EQUIPMENT "RENTAL" COST        =  %9.2f \n\n', Annual_Rental_Cost);
fprintf('    NET OPERATING COST, $          =  %9.2f \n\n', Annual_Net_Operating_Cost);
fprintf('    ANNUAL INCOME, $               =  %9.2f \n\n', Annual_Income);
fprintf('    OPERATING PROFIT, $            =  %9.2f \n\n', Annual_Profit);
%
%   STEP-3(E):  DISPLAY THE TIME_DEPENDENT RESPONSE OF THE BATCH REACTOR
%
print_decision = input('Would you like to plot the Batch Reactor dynamics? print y (yes) or n (no). So, y or n?.....', 's');
if print_decision == 'y'
    FigureNumber = FigureNumber + 1;
    TransientPlots(ReactorTimeVector, Reactor_dynamics);
end
%
end