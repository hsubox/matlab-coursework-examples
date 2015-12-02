function HW_12
% Jennifer Hsu
% 3/29/2011

global V;
V = 0.1; % m^3
% V = 1; % m^3

% clear home screen
clear
clc

% 1. -----------------------------

% Control volume 1
% X_1 + X_5 - X_2 = 0
% Y_1 + Y_5 - Y_2 = 0
% Z_1 + Z_5 - Z_2 = 0

% Control volume 2 (Reactor)
% X_2 - 1*E - X_3 = 0
% Y_2 - 2*E - X_3 = 0
% Z_2 + 1*E - X_3 = 0

% Control volume 3
% X_3 - X_4 - X_5 = 0
% Y_3 - Y_4 - Y_5 = 0
% Z_3 - Z_4 - Z_5 = 0

% Other
% X_5 = X_3*R
% Y_5 = Y_3*R
% Z_5 = Z_3*R

% X_1 = 0.3; % mol/s
% Y_1 = 0.7; % mol/s

% 2. -----------------------------

E = 0.2; % mol/s
R = 0.5; % mol/s
[X_1, Y_1, Z_1, X_2, Y_2, Z_2, X_3, Y_3, Z_3, X_4, Y_4, Z_4, X_5, Y_5, Z_5] = reactor(E, R)

% all in mol/s
% X_1 =
%     0.3000
% Y_1 =
%     0.7000
% Z_1 =
%      0
% X_2 =
%     0.4000
% Y_2 =
%     1.0000
% Z_2 =
%     0.2000
% X_3 =
%     0.2000
% Y_3 =
%     0.6000
% Z_3 =
%     0.4000
% X_4 =
%     0.1000
% Y_4 =
%     0.3000
% Z_4 =
%     0.2000
% X_5 =
%     0.1000
% Y_5 =
%     0.3000
% Z_5 =
%     0.2000

[Px_3, Py_3, Pz_3] = partial_pressures(X_3, Y_3, Z_3)
% Partial pressures of stream 3 (same as reactor)
% Px_3 =
%     0.1667 % bar
% Py_3 =
%     0.5000 % bar
% Pz_3 =
%     0.3333 % bar

% 3. -----------------------------
global V;
r = 8.314; % J/molK
A = 3*10^12; % mol/m^3atm^3s
Ea = 60*10^3; % J/mol
S = -160; % J/molK
H = -70*10^3; % J/molK
T = 400; % K

Keq = exp(S/r)*exp(-H/(r*T))
E = V*A*exp(-Ea/(r*T))*(Px_3*(Py_3)^2 - (Pz_3/Keq))
% Keq =
%   6.0750
% E =
%   -57.8507 % mol/s

% No, E = -57.85 != 0.2 mol/s as in part 2.

% 4. -----------------------------
global R_global T_global;

% R_global = 0.5;
% T_global = 500;
% E_actual = bisect(@all_eqns_satisfy,[10^-10 0.3-10^-10],[-10^-100 10^-100],[-10^-100 10^-100])

% Plot extent of reaction for various R's and T's
% Sets limits for R and T in graph
% Uses 20 points on each axis to plot
[R_gr,T_gr] = meshgrid(linspace(.2,.8,25), linspace(200,1000,25));
[E_gr,~] = arrayfun(@E_for_R_and_T, R_gr, T_gr);
% surf(R_gr,T_gr,E_gr);

figure(1);
[c, h] = contour(R_gr,T_gr,E_gr,10);
clabel(c, h);
xlabel('Recycled proportion, R');
ylabel('Temperature (K)');
zlabel('Extent of reaction, E');
title('E(R,T)');

% Plot mole fraction of Z for various R's and T's
[~,Pz] = arrayfun(@E_for_R_and_T, R_gr, T_gr);
% surf(R_gr,T_gr,Pz);

figure(2);
[c, h] = contour(R_gr,T_gr,Pz,10);
clabel(c, h);
xlabel('Recycled proportion, R');
ylabel('Temperature (K)');
zlabel('Mole fraction of Z, Xz');
title('Xz(R,T)');

% Does increasing the recycle ratio increase the production of Z when the 
% system is reaction controlled? No.
% When the system is equilibrium controlled?
% The system is equilibrium controlled where mole fraction of z coming out
% is equal to the amount expected by the equilibrium constant. (Discussed
% more in part 5.

    function [E_actual, Pz] = E_for_R_and_T(R,T)
        % Sets R and T which is passed globally into all_eqns_satisfy
        R_global = R;
        T_global = T;
        % Finds E by bisection method
        E_actual = bisect(@all_eqns_satisfy,[10^-10 0.3-10^-10]);
        % fprintf('R=%g, T=%g, E=%g\n',R_global,T_global,E_actual);
        [~,~,~,~,~,~,X_3,Y_3,Z_3,~,~,~,~,~,~] = reactor(E_actual, R_global);
        [~, ~, Pz] = partial_pressures(X_3, Y_3, Z_3); % partial pressure = mol fraction where pressure = 1
    end

% 5. -----------------------------

Keq_gr = arrayfun(@diff_in_Keq, R_gr, T_gr);

figure(4);
plot(T_gr(:,1),Keq_gr(:,1));
xlabel('Temperature (K)');
ylabel('Difference in calculated Keq');
title('Keq(Px,Py,Pz) - Keq(T)');

% The system is equilibrium controlled where T > approx 250 K.
% It is reaction controlled for higher T > ~250 K. (Where V = 0.1 m3).

% For V = 1 m3, the reaction proceed further (higher extent of reaction)
% and is equilibrium controlled at a slightly lower T.

% The only change in script file for 0.1 m3 to 1.0 m3 is the global
% variable V found at the beginning of the script. 

    function K = diff_in_Keq(R, T)
        % Sets R and T which is passed globally into all_eqns_satisfy
        R_global = R;
        T_global = T;
        % Finds E by bisection method
        E_actual = bisect(@all_eqns_satisfy,[10^-10 0.3-10^-10]);
        % Calculates difference in Keq
        K = diff_in_Keq2(E_actual);
        
        % fprintf('R=%g, T=%g, E=%g, K=%g\n',R_global,T_global,E_actual,K);
    end

end

% Solves for X, Y, Z in Streams 1-5 given E and R
function [X_1, Y_1, Z_1, X_2, Y_2, Z_2, X_3, Y_3, Z_3, X_4, Y_4, Z_4, X_5, Y_5, Z_5] = reactor(E, R)

X_1 = 0.3; % mol/s
Y_1 = 0.7; % mol/s
Z_1 = 0; % mol/s

X_4 = X_1 - 1*E;
Y_4 = Y_1 - 2*E;
Z_4 = Z_1 + 1*E;

X_3 = X_4/(1-R);
Y_3 = Y_4/(1-R);
Z_3 = Z_4/(1-R);

X_5 = X_3*R;
Y_5 = Y_3*R;
Z_5 = Z_3*R;

X_2 = X_1 + X_5;
Y_2 = Y_1 + Y_5;
Z_2 = Z_1 + Z_5;

end

function [Px_3, Py_3, Pz_3] = partial_pressures(X_3, Y_3, Z_3)
% calculates partial pressures based on stream 3
% same as in reactor
% P_total = 1; % bar
total_3 = X_3 + Y_3 + Z_3;
Px_3 = X_3/total_3;
Py_3 = Y_3/total_3;
Pz_3 = Z_3/total_3;
end

function E_calculated = calcE(Px_3, Py_3, Pz_3)
% calculates E from Eqns(1)

% access global variables
global T_global V;
% declares variables
r = 8.314; % J/molK
A = 3*10^12; % mol/m^3atm^3s
Ea = 60*10^3; % J/mol
S = -160; % J/molK
H = -70*10^3; % J/molK

Keq = exp(S/r)*exp(-H/(r*T_global));
E_calculated = V*A*exp(-Ea/(r*T_global))*(Px_3*(Py_3)^2 - Pz_3/Keq);
end

% Calculates difference between guess and "actual" E
% run through bisection function to find true actual E
function x = all_eqns_satisfy(E_guess)
global R_global

% solves set of linear equations using E_guess
[~,~,~,~,~,~,X_3,Y_3,Z_3,~,~,~,~,~,~] = reactor(E_guess, R_global);

% calculates partial pressures
[Px_3, Py_3, Pz_3] = partial_pressures(X_3, Y_3, Z_3);

% calculates E
E_calculated = calcE(Px_3, Py_3, Pz_3);

% calculates error of guess and calculated E
x = E_guess - E_calculated;
end

% finds difference between E calculated by partial pressures and E
% calculated by temperature
function x = diff_in_Keq2(E_actual)
% imports global variables
global R_global;
global T_global;
global V;
% declares variables
r = 8.314; % J/molK
A = 3*10^12; % mol/m^3atm^3s
Ea = 60*10^3; % J/mol
S = -160; % J/molK
H = -70*10^3; % J/molK

% Method using partial pressures
% solves set of linear equations using E_actual
[~,~,~,~,~,~,X_3,Y_3,Z_3,~,~,~,~,~,~] = reactor(E_actual, R_global);
% calculates partial pressures
[Px_3, Py_3, Pz_3] = partial_pressures(X_3, Y_3, Z_3);

Keq_p = (Pz_3)^2/(Px_3*(Py_3^2));

% Method using temperature
Keq_t = exp(S/r)*exp(-H/(r*T_global));

% Calculates difference
x = Keq_p - Keq_t;

end