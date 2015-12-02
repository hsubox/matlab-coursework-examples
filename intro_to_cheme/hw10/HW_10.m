function HW_10
% HW_10
% Jennifer Hsu
% 3/15/2010

disp('All answers are written in comments!')

% Variables
% I = Total molar flow in stream (mol/min)
% E = Total molar flow in stream (mol/min)
% R = Total molar flow in stream (mol/min)
% P = Total molar flow in stream (mol/min)
% ? = Efficiency of reaction (mol/min)
% nnC4 = Molar flow in purge stream of nC4 (mol/min)
% niC4 = Molar flow in purge stream of iC4 (mol/min)
% nJ = Molar flow in purge stream of J (mol/min)

% 1.

% Total material of mixer
% 1 mol/min + R – I = 0
% Three material balances for each species on reactor
% 0.8910*I – 0.6200*E – 1*? = 0
% 0.1082*I - 0.3792*E + 1*? = 0
% 0.0008*I - 0.0008*E = 0
% Total material balance on the system consisting of the mixer, splitter, and distillation column
% 1 mol/min – I + E – P – nnC4 – niC4 – nJ = 0
% Material balance of iC4 on the system consisting of the mixer, splitter, and distillation column
% 0 mol/min – 0.1082*I + 0.3792*E – 0.9893*P – niC4 = 0

% Original matrix
A_1 = [-1	0	1	0	0	0	0	0; ...
    0.8910	-0.6200	0	0	-1	0	0	0; ... % Linearly dependent
    0.1082	-0.3792	0	0	1	0	0	0; ...
    0.0008	-0.0008	0	0	0	0	0	0; ...
    -1	1	0	-1	0	-1	-1	-1; ...
    -0.1082	0.3792	0	-0.9893	0	0	-1	0];
% b_1 = [-1 0 0 0 -1 0]';

% 2.
rank_A_1 = rank(A_1)
% ans =
% 
%      5
% We have 6 equations. The rank is 5. One of them is not linearly independent.

A_2 = [-1	0	1	0	0	0	0	0; ...
    0.1082	-0.3792	0	0	1	0	0	0; ...
    0.0008	-0.0008	0	0	0	0	0	0; ...
    -1	1	0	-1	0	-1	-1	-1; ...
    -0.1082	0.3792	0	-0.9893	0	0	-1	0];
rank_A_2 = rank(A_2)
% 2nd equation removed. When removed rank is still 5, telling us that it is
% dependent on the other equations.
% b_2 = [-1 0 0 -1 0]';

% 3.
% Material balance of J on the system consisting of the mixer, splitter, 
% and distillation column
% .001 mol/min – 0.0008*I + 0.0008*E – 0.0008*P – nJ = 0
% Material balance of J on the whole system (there is no reaction involving
% J, so what comes in at the feed must come out of the upper distillate and
% purge).
% .001 mol/min – 0.0008*P – nJ = 0

A_3a = [-1	0	1	0	0	0	0	0; ...
    0.1082	-0.3792	0	0	1	0	0	0; ...
    0.0008	-0.0008	0	0	0	0	0	0; ...
    -1	1	0	-1	0	-1	-1	-1; ...
    -0.1082	0.3792	0	-0.9893	0	0	-1	0; ...
    -0.0008	0.0008	0	-0.0008	0	0	0	-1; ...
    0	0	0	-0.0008	0	0	0	-1];
% b_3a = [-1 0 0 -1 0 -0.001 -0.001]';

rank_A_3a = rank(A_3a)
% ans =
% 
%      6
% We do not have a matrix of full rank since we have 7 equations. Replace 
% one of newly added equations (7).

A_3b = [-1	0	1	0	0	0	0	0; ...
    0.1082	-0.3792	0	0	1	0	0	0; ...
    0.0008	-0.0008	0	0	0	0	0	0; ...
    -1	1	0	-1	0	-1	-1	-1; ...
    -0.1082	0.3792	0	-0.9893	0	0	-1	0; ...
    -0.0008	0.0008	0	-0.0008	0	0	0	-1
    0	0	0	0	1	0	0	0]; % new with extent of reaction
% b_3b = [-1 0 0 -1 0 -0.001 0.97]';

rank_A_3b = rank(A_3b)

% 4.

% We have 8 variables and only 7 equations. Cannot solve system yet...
% Now adding the new information. The total molar flow rate of the purge 
% stream is 0.03 mol/min. Now we have 8 variables and 8 equations and can
% solve!
A_4 = [-1	0	1	0	0	0	0	0; ...
    0.1082	-0.3792	0	0	1	0	0	0; ...
    0.0008	-0.0008	0	0	0	0	0	0; ...
    -1	1	0	-1	0	-1	-1	-1; ...
    -0.1082	0.3792	0	-0.9893	0	0	-1	0; ...
    -0.0008	0.0008	0	-0.0008	0	0	0	-1
    0	0	0	0	1	0	0	0; ...
    0	0	0	0	0	1	1	1];
b_4 = [-1 0 0 -1 0 -0.001 0.97 0.03]';
rank_A_4 = rank(A_4);
% ans =
% 
%      8
% Have a set of 8 independent equations to solve

% 5.
x = A_4\b_4

% x =
% 
%    3.5793  <- total molar flow in stream I (mol/min)
%    3.5793  <- total molar flow in stream E (mol/min)
%    2.5793  <- total molar flow in stream R (mol/min)
%    0.9700  <- total molar flow in stream P (mol/min)
%    0.9700  <- efficiency of reaction (mol/min)
%    0.0194  <- molar flow in purge stream of nC4 (mol/min)
%    0.0104  <- molar flow in purge stream of iC4 (mol/min)
%    0.0002  <- molar flow in purge stream of J (mol/min)

% 6. 

% Conversion = 1 - out_nC4/in_nC4
conv_reactor = 1 - (0.6200*3.5793)/(0.8910*3.5793)
conv_system = 1 - (0.0099*0.9700 + 0.0194)/.999

% conv_reactor =
% 
%     0.3042
% 
% 
% conv_system =
% 
%     0.9710

% The conversion of nC4 in the reactor is 30.4%. The overall conversion of
% nC4 is 97.1%. Recycling makes this possible because it brings back a
% large proportion of unreacted nC4 and small amounts iC4 so that more can 
% be converted into iC4.
end