function HW06

% Author: Jennifer Hsu
% Created: 02/22/2011
% Last Modified: 02/25/2011

% clear command window
clear
clc

% Air: 79 mol% N2 and 21 mol% O2
% C8H18 + 12.5 O2 + 47.0238 N2 -> 8 CO2 + 9 H20 + 47.0238 N2

% Inputs:  T_outlet (output temperature in Kelvin), fueling_rate (fueling rate in kg/hr)
% Output: work (in J/g)
function work = findW(T_outlet, fueling_rate)

% If forced output
work = 0;

% Inlet conditions
T_inlet = 298; % Temperature (Kelvin)
P_inlet = 1.0; % Pressure (atm)
ID_inlet = 0.01; % Diameter (m) = 1 cm
% Air (g), Fuel (l)

% Exhaust conditions
% Temperature (Kelvin), taken as input
P_outlet = 1.5; % Pressure (atm)
ID_outlet = 0.05; % Diameter (m) = 5 cm
% All gases

C8H10_m = fueling_rate * 1000 / (60^2); % Fueling rate X000/60^2 (g/s) = X kg/hr
C8H10_molar_mass = 114.2285; % Molar mass of iso-octane (g/mol)
rxn_k = C8H10_m / C8H10_molar_mass; % Reaction scalar based on fueling rate (mol/s)

% Change in kinetic energy
% Neglect the kinetic energy of the fuel entering the engine
n_in = rxn_k * (12.5 + 47.0238); % *gas* reactants (mol/s)
n_out = rxn_k * (8 + 9 + 47.0238); % products (mol/s)
% C8H18 + 12.5 O2 + 47.0238 N2 -> 8 CO2 + 9 H20 + 47.0238 N2
m_in = rxn_k * ((12.5*2*15.9994) + (47.0238*28.0134)) / 1000; % mass of *gas* reactants (kg/s)
m_out = rxn_k * ((8*44.0096) + (9*18.01528) + (47.0238*28.0134)) / 1000; % mass of products (kg/s)
% Finds velocity (m/s) = V* / A = n* R T / P A, from ideal gas law
function velocity = vel(n, T, P, d)
    R = 8.205746e-5; % Gas constant (m^3 atm / K mol)
    area = (d/2)^2 * pi; % m^2
    velocity = (n.*R.*T) ./ (P .* area); % m/s
end
KE_in = 0.5 * m_in .* vel(n_in, T_inlet, P_inlet, ID_inlet).^2; % W
KE_out = 0.5 * m_out .* vel(n_out, T_outlet, P_outlet, ID_outlet).^2; % W
KE_delta = KE_out - KE_in; % W

% Heat loss to the environment
h = 2.5; % W/K
Q = h .* (T_outlet - T_inlet); % W

% Enthalpy of formations at 298K and 1atm (J/mol)
C8H10_H = -259300; % J/mol
% O2, N2 = 0
H_in = rxn_k * C8H10_H; % Enthalpy of scaled reaction (W)

% Shomate coefficients
% CO2 (gas)
CO2_Sdata = [24.99735 55.18696 -33.69137 7.948387 -0.136638 -403.6075 228.2431 298 1200; 58.16639 2.720074 -0.492289 0.038844 -6.447293 -425.9186 263.6125 1200 6000]';
% H2O (gas)
H2O_Sdata = [30.09200 6.832514 6.793435 -2.534480 0.082139 -250.8810 223.3967 500 1700; 41.96426 8.622053 -1.499780 0.098119 -11.15764 -272.1797 219.7809 1700 6000]';
% N2 (gas)
N2_Sdata = [28.98641 1.853978 -9.647459 16.63537 0.000117 -8.671914 226.4168 100 500; 19.50583 19.88705 -8.598535 1.369784 0.527601 -4.935202 212.3900 500 2000; 35.51872 1.128728 -0.196103 0.014662 -4.553760 -18.97091 224.9810 2000 6000]';

% Checks if in exhaust T range
if (T_outlet < 500)
    disp('Error: Out of shomate temperature range.');
    return
end
if (T_outlet > 6000)
    disp('Error: Out of shomate temperature range,');
    return
end

% Finds proper coefficients for Shomate equation based on exhaust
% temperature (K) and calculates enthalpy (kJ!!!)
% CO2
[~,H_CO2_out,~] = Shomate(T_outlet',CO2_Sdata);
% H2O
[~,H_H2O_out,~] = Shomate(T_outlet',H2O_Sdata);
% N2
[~,H_N2_out,~] = Shomate(T_outlet',N2_Sdata);

% Enthalpies of formation
% H_CO2_298 = -393522; % J/mol
% H_H2O_298 = -241826; % J/mol
% H_N2_298 = 0
H_out = rxn_k .*(((8*H_CO2_out + 9*H_H2O_out + 47.0238*H_N2_out) .* 1000))'; % J / s
H_delta = H_out - H_in;

% Change in Potential Energy = 0

work = -(H_delta + KE_delta) - Q; % W

end

% 1.
% use findW function to find work
% exhaust temperature = 700 Kelvin,
% fuel rate = 3 kg/hr
ex_temp = 700;
fuel_rate = 3;
work = findW(ex_temp, fuel_rate); % W
%d
disp('1.');
fprintf('For an exhaust temperature of %.2f K and a fuel rate of\n%.2f kg/hr the work produced will be %.2f Watts.\n', ex_temp, fuel_rate, work);

% 2a. W = 0, fuel_rate = 0.2
fuel_rate = 0.2;
% Finds work as a function of exhaust temperature and fuel rate of 0.2
% kg/hr
function work = findW2(T)
    work = findW(T, fuel_rate);
end
% Graphs Work as a function of exhaust temperature for a fuel rate of 0.2
% T = 500:6000; % K
% work = findW2(T); % W
% plot(T,work);
% xlabel('Temperature (Kelvin)');
% ylabel('Work (Watts)');
% title('Work Output by Car Engine');

% Uses default error of bisect function
% Bisect looks for a zero between 500 and 1500 K, fuel rate is 0.2 kg/hr
r = bisect(@findW2,[500,1500]);

disp('2a. Using the function bisect,');
fprintf('for an idling engine (W = 0) and a fuel rate of %1.2f kg/hr,\nthe exhaust temperature at steady state is %.2f K.\n', fuel_rate, r);

% 2b.
% Hides display output from fsolve
options = optimset('Display','off');
s = fsolve(@findW2,1000,options);

disp('2b. Using the function fsolve,');
fprintf('for an idling engine (W = 0) and a fuel rate of %1.2f kg/hr,\nthe exhaust temperature at steady state is %.2f K.\n', fuel_rate, s);

end

% SAMPLE OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1.
% For an exhaust temperature of 700.00 K and a fuel rate of
% 3.00 kg/hr the work produced will be 29999.23 Watts.
% 2a. Using the function bisect,
% for an idling engine (W = 0) and a fuel rate of 0.20 kg/hr,
% the exhaust temperature at steady state is 992.84 K.
% 2b. Using the function fsolve,
% for an idling engine (W = 0) and a fuel rate of 0.20 kg/hr,
% the exhaust temperature at steady state is 992.84 K.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%