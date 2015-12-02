function HW_09
% Author: Jennifer Hsu
% Created: 03/12/2011
% Last Modified: 03/13/2011

% % clear command window
clear
clc

% Takes in values from coefficient matrix (A)
[A,~,~] = xlsread('HW9 Student File.xls', 'Sheet1', 'C2:AX49');
% Takes in values from right-hand side matrix (b)
[b,~,~] = xlsread('HW9 Student File.xls', 'Sheet1', 'AZ2:AZ49');
% Output A, b
% A, b;

% calculates values of variables
x = A\b;

% Takes in names of variables
[~,~,vars] = xlsread('HW9 Student File.xls', 'Sheet1', 'C1:AX1');
% Data written to HW9 Output Values.xls
xlswrite('HW9 Output Values', vars', 'Sheet1', 'A1:A48');
xlswrite('HW9 Output Values', x, 'Sheet1', 'B1:B48');
disp('Output to "HW9 Output Values.xls"');
end