function HW_14

% Jennifer Hsu
% 4/18/2011

% clear home screen and figures
clear;
clc;
clf;

options = optimset('Display','off');

%% Part 1(a)
disp('Part 1(a)');
F_in = 0.3; % L/s
V_reactor = 200; % L
% (dM/dt) = [(2 mol/L)(0.3 L/s) - M*(0.3 L/s)] / (200 L)
%         = 0.003 mol/L*s - 0.0015*M /s
%         = 0.0015(2 - M)
% dM/(2-M) = 0.0015 dt
% -ln(2-M) = 0.0015*t + C
% 2 - M = A*exp(-0.0015*t), and at t = 0, M = 0
% M = 2 - 2*exp(-0.0015*t)
% time constant tau = 1/(0.0015) = 666.67 sec
tau = V_reactor/F_in; % sec
% tau = 666.67 sec
fprintf('The time constant is %g seconds.\n', tau);

% to reach 90% of its steady-state value
% (1 - .90) = exp(-t/tau)
t = -log(.1)*tau; % seconds
% t = 1531 seconds

% steady state value = 2 mole/liter
% M = 2 - 2*exp(-0.0015*t)
% as t -> infinity, M = 2 mole/liter
fprintf('It takes the [NaCl] in the reactor %g seconds to reach 90%%\nof its steady state value, 2 mol/L.\n', t);

% plot concentration of [NaCl] in the reactor over time
time = linspace(0,4000);
conc = 2 - 2*exp(-time./tau);
figure(1);
clf;
plot(time, conc, 'b','DisplayName','F_i_n = 0.30L/s');
xlabel('Time (seconds)');
ylabel('Concentration of NaCl (mol/L)');
title ('Concentration of [NaCl] in reactor');
fprintf('See figure 1.\n\n');

%% Part 1(b)
disp('Part 1(b)');

T_env = 20; % Temperature of the environment = 293 Kelvin
T_in = 60; % Temperature of water in = 333 Kelvin
Q_stir = 200; % Heat from stirring, W or J/s
C_H2O = 4.18; % Heat capacity of water, J/g*K
density = 1000; % grams/Liter
% Q = hA(T_env - T_reactor) + 200;
hA = 15; % W/K
% T = Q[J/s]*(g*K/4.18J)*(1L/1000g)*(1/200L) => [K]
% dT/dt = (333*0.3 - T*0.3)/200 + (15*(293-T) + 200)/(200*1000*4.18)
% dT/dt = (T_in*F_in - T*F_in)/V_reactor + (hA*(T_env-T) + Q_stir)/(V_reactor*density*C_H2O)
% dT/dt = (T_in*F_in/V_reactor) - T*(F_in/V_reactor) + (hA*T_env)/(V_reactor*density*C_H2O) - (hA*T)/(V_reactor*density*C_H2O) + (Q_stir)/(V_reactor*density*C_H2O)
% dT/dt = (T_in*F_in/V_reactor) + (hA*T_env)/(V_reactor*density*C_H2O) + (Q_stir)/(V_reactor*density*C_H2O)
%           - T*(F_in/V_reactor) - (hA*T)/(V_reactor*density*C_H2O)
const = (T_in*F_in/V_reactor) + (hA*T_env)/(V_reactor*density*C_H2O) + (Q_stir)/(V_reactor*density*C_H2O);
coeff = -(F_in/V_reactor) - hA/(V_reactor*density*C_H2O);
tau_1b = -1/coeff;
fprintf('The time constant is %g seconds.\n', tau_1b);
fprintf('It does not depend on the initial temperature because the \ndifferential equation is time-invariant.\n');
% time constant = 658.7864 seconds
% does not depend on initial temperature because the differential equation
% is time-invariant
T_0 = 10; % Initial temperature
A = T_0 + (const/coeff);
T = (-1*const/coeff) + A*exp(coeff.*time);
% temperature = 59.6848 - 49.6848*exp(-0.0015*time)
% steady-state temperature with hot water running = 332.7 K or 59.5 deg C

% fprintf('temperature (deg C) = %g + %g*exp(-time/%g)\n', -1*const/coeff, A, tau_1b);
fprintf('The steady state temperature is %g deg C.\n', -1*const/coeff);

% plot the temperature in the reactor as a function of time
figure(2);
clf;
hold on;
plot(time, T, 'b', 'DisplayName','hA = 15W/K');  % line is shown in blue
xlabel('Time (seconds)');
ylabel('Temperature (K)');
title ('Temperature in reactor');


T_f = 45; % deg C - how long does it take to reach this temperature?
t_45C = fsolve(@findT45, 800,options);
% The time to reach 45 deg C is 802.9848 seconds.
fprintf('It takes the reactor %g seconds to reach %g deg C.\n', t_45C, T_f);

    function x = findT45(t)
        x = ((-1*const/coeff) + A*exp(coeff*t)) - T_f;
    end

% This plot is combined with the part 2(d)
fprintf('See figure 2.\n\n');

%% Part 1(c)
disp('Part 1(c)');

T_steady = 45; % deg C = 318 Kelvin
% dT/dt = 0 = (T_warm*F_in - T_steady*F_in)/V_reactor + (hA*(T_env - T_steady) + 200)/(V_reactor*density*C_H2O);
T_warm = (-(T_steady*F_in/V_reactor) + (hA*(T_env - T_steady) + 200)/(V_reactor*density*C_H2O))/(-1*F_in/V_reactor);
% T_warm = 45.14 deg C or 318.1396 K
fprintf('T_warm = %g deg C.\n\n', T_warm);

%% Part 2(a)
disp('Part 2(a)');

% Steady state composition of output stream

k = 100; % L/mol*sec
Q = 100; % L/mol
E = 10^-6; % mol/L
sum1 = 0.01; % mol/L, sum of [D] + [L] is constant

L_eq = fsolve(@steadystate, .005,options);
% L_eq = 3.1250e-004; mol/s
D_eq = sum1 - L_eq;
% D_eq =  0.0097 mol/s
ratio = L_eq/D_eq;
% ratio = 0.0323
% epsilon = ((k*E*D) - (k*E*L))*V_reactor/(1 + (Q*D) + (Q*L));
% epsilon = (k*E*(0.01 - (2*L)))*V_reactor/(1 + (Q*0.01));
disp('Steady state composition of the output stream');
fprintf('[L]_eq = %g mol/L\n', L_eq);
fprintf('[D]_eq = %g mol/L\n', D_eq);
fprintf('[E]_eq = %g mol/L\n', E);
fprintf('L to D ratio = %g\n', ratio);

% V_reactor*dL/dt = epsilon - F_in*L;
% V_reactor*dL/dt = (k*E*(0.01 - (2*L)))*V_reactor/(1 + (Q*0.01)) - F_in*L;
% Wolfram Alpha!!!
% L(t) = c_1 e^(-0.0016 t)+0.0003125 e^(0 t)

tau_2a = 1/0.0016; % time constant = 625 seconds!
fprintf('The time constant is %g seconds.\n\n', tau_2a);

    function x = steadystate(L)
        % epsilon = ((k*E*D) - (k*E*L))*V_reactor/(1 + (Q*D) + (Q*L));
        % [D] = 0.01 mol/L - [L]
        % steady state: 0 = epsilon - [L]out
        % epsilon = [L] = (k*E*(sum1 - (2*L)))*V_reactor/(1 + (Q*sum1));
        x = ((k*E*(sum1 - (2*L)))*V_reactor/(1 + (Q*sum1))) - F_in*L;
    end
%% Part 2(b)
disp('Part 2(b)');

T_0 = 45; % deg C, initial temperature of the reactor = 318 K
coeff = -hA/(V_reactor*density*C_H2O);
% tau_2b = -1/coeff;
% time constant = 5.5733e+004 sec
% fprintf('The time constant is %g seconds.\n', tau_2b);

time = linspace(0,500000);
A = T_env - T_0;
T = T_env - A*exp(coeff.*time);

figure(3);
plot(time, T);
xlabel('Time (seconds)');
ylabel('Temperature (K)');
title ('Temperature in cooling reactor');

T_f = 30; % K = Final temperature 30 deg C

t_30C = fsolve(@findT30, 5*10^4,options);
% The time to reach 30 deg C is 51068 seconds.
fprintf('It takes the reactor %g seconds to reach %g deg C.\n', t_30C, T_f);

    function x = findT30(t)
        x = T_env - A*exp(coeff*t) - T_f;
    end

fprintf('See figure 3.\n\n');

%% Part 2(c)
disp('Part 2(c)');

time = linspace(0, 4000);

% Flow is INcreased 20%
disp('Flow Increased 20%:');
F_in = (1.2)*(0.3); % = 0.3600 L/s
tau_2c1 = V_reactor/F_in; % sec
fprintf('The time constant is %g seconds.\n', tau_2c1);

t = -log(.1)*tau_2c1; % seconds
fprintf('It takes the [NaCl] in the reactor %g seconds to reach 90%%\nof its steady state value, 2 mol/L.\n', t);

conc = 2 - 2*exp(-time./tau_2c1);
figure(1);
hold on;
plot(time, conc, 'r','DisplayName','F_i_n = 0.36L/s');
fprintf('See figure 1.\n\n');

% Flow is DEcreased 20%
disp('Flow Decreased 20%:');
F_in = (0.8)*(0.3); % = 0.2400 L/s
tau_2c2 = V_reactor/F_in; % sec
fprintf('The time constant is %g seconds.\n', tau_2c2);

t = -log(.1)*tau_2c2; % seconds
fprintf('It takes the [NaCl] in the reactor %g seconds to reach 90%%\nof its steady state value, 2 mol/L.\n', t);

conc = 2 - 2*exp(-time./tau_2c2);
figure(1);
hold on;
plot(time, conc, 'g','DisplayName','F_i_n = 0.24L/s');
fprintf('See figure 1.\n\n');

legend show;

%% Part 2(d)
disp('Part 2(d)');

F_in = 0.3; % L/s
T_0 = 10; % deg C, initial temperature of reactor

% hA is INcreased 20%
disp('hA Increased 20%:');
hA = 1.2*15; % = 18 W/K

const = (T_in*F_in/V_reactor) + (hA*T_env)/(V_reactor*density*C_H2O) + (Q_stir)/(V_reactor*density*C_H2O);
coeff = -(F_in/V_reactor) - hA/(V_reactor*density*C_H2O);
tau_2d1 = -1/coeff; % 657.2327 sec
fprintf('The time constant is %g seconds.\n', tau_2d1);
A = T_0 + (const/coeff);
T = (-1*const/coeff) + A*exp(coeff.*time);
% temperature = 59.5912 - 49.5912*exp(-0.0015*time)
% steady-state temperature with hot water running = 59.6 deg C
fprintf('The steady state temperature is %g deg C.\n', -1*const/coeff);

% plot the temperature in the reactor as a function of time
figure(2);
plot(time, T, 'c', 'DisplayName','hA = 18W/K'); % line is shown in cyan

T_f = 45; % deg C - how long does it take to reach this temperature?
t_45C = fsolve(@findT45, 800,options); % 804.055 seconds
fprintf('It takes the reactor %g seconds to reach %g deg C.\n', t_45C, T_f);
fprintf('See figure 2.\n\n');

% hA is DEcreased 20%
disp('hA Decreased 20%:');
hA = 0.8*15; % = 12 W/K
const = (T_in*F_in/V_reactor) + (hA*T_env)/(V_reactor*density*C_H2O) + (Q_stir)/(V_reactor*density*C_H2O);
coeff = -(F_in/V_reactor) - hA/(V_reactor*density*C_H2O);
tau_2d2 = -1/coeff; %  660.3476 sec
fprintf('The time constant is %g seconds.\n', tau_2d2);

A = T_0 + (const/coeff);
T = (-1*const/coeff) + A*exp(coeff.*time);
% temperature = 59.7788 - 49.7788*exp(-0.0015*time)
% steady-state temperature with hot water running = 59.8 deg C
fprintf('The steady state temperature is %g deg C.\n', -1*const/coeff);

t_45C = fsolve(@findT45, 800,options); % 801.921 seconds
fprintf('It takes the reactor %g seconds to reach %g deg C.\n', t_45C, T_f);

% plot the temperature in the reactor as a function of time
figure(2);
plot(time, T,'m','DisplayName','hA = 12W/K'); % line is shown in magenta
legend show;
fprintf('See figure 2.\n\n');
disp('See script for additional comments!');

end


% Sample Output ----------------------------------------------------------
% Part 1(a)
% The time constant is 666.667 seconds.
% It takes the [NaCl] in the reactor 1535.06 seconds to reach 90%
% of its steady state value, 2 mol/L.
% See figure 1.
% 
% Part 1(b)
% The time constant is 658.786 seconds.
% It does not depend on the initial temperature because the 
% differential equation is time-invariant.
% The steady state temperature is 59.6848 deg C.
% It takes the reactor 802.986 seconds to reach 45 deg C.
% See figure 2.
% 
% Part 1(c)
% T_warm = 45.1396 deg C.
% 
% Part 2(a)
% Steady state composition of the output stream
% [L]_eq = 0.0003125 mol/L
% [D]_eq = 0.0096875 mol/L
% [E]_eq = 1e-006 mol/L
% L to D ratio = 0.0322581
% The time constant is 625 seconds.
% 
% Part 2(b)
% It takes the reactor 51067.9 seconds to reach 30 deg C.
% See figure 3.
% 
% Part 2(c)
% Flow Increased 20%:
% The time constant is 555.556 seconds.
% It takes the [NaCl] in the reactor 1279.21 seconds to reach 90%
% of its steady state value, 2 mol/L.
% See figure 1.
% 
% Flow Decreased 20%:
% The time constant is 833.333 seconds.
% It takes the [NaCl] in the reactor 1918.82 seconds to reach 90%
% of its steady state value, 2 mol/L.
% See figure 1.
% 
% Part 2(d)
% hA Increased 20%:
% The time constant is 657.233 seconds.
% The steady state temperature is 59.5912 deg C.
% It takes the reactor 804.055 seconds to reach 45 deg C.
% See figure 2.
% 
% hA Decreased 20%:
% The time constant is 660.348 seconds.
% The steady state temperature is 59.7788 deg C.
% It takes the reactor 801.921 seconds to reach 45 deg C.
% See figure 2.
% 
% See script for additional comments!