function HW_03
% Author: Jennifer Hsu
% Created: 02/09/2011

% clear command window
clear
clc

% 1.
disp('Problem 1')
% Input: s, k <= integers
% Output: f(s,k) = summation of 1/(n^s) for n = 1 to k
function rz = RiemannZetaFunction(s,k)
    rz = 0;
    for n = 1:k
        rz = rz + 1/(n^s);
    end
end

% Test function
RZFs3k6 = RiemannZetaFunction(3,6)

%2.
disp('Problem 2')
% Input: j <- positive integer
% Output: j! = j*(j-1)*(j-2)*...*1
function f = factorial_HW03(j)
    f = 1;
    for n = 1:j
        f = f * n;
    end
end

% Test function
fact5 = factorial_HW03(5)

% 3.
disp('Problem 3')
% Input: m <- positive integer (assumed m <= 7)
% Output: Riemann Zeta Function (Even)
function rze = RiemannZetaFunction_Even(m)
    rze = ((-1)^(m+1)) * (Bernouilli(2*m) * ((2*pi)^(2*m))) / (2 * factorial_HW03(2*m));
end
% Test Function
RZF_E3 = RiemannZetaFunction_Even(3)

% Input: positive even integer up to 14
% Output: Bernouilli number
function b = Bernouilli(s)
    switch s
        case 2
            b = 1/6;
        case {4, 8}
            b = -1/30;
        case 6
            b = 1/42;
        case 10
            b = 5/66;
        case 12
            b = -691/2730;
        case 14
            b = 7/6;
        otherwise
            disp('Unknown Bernouilli number!');
    end
end
% % Test Function
% Bernouilli(1)
% Bernouilli(2)
% Bernouilli(8)
% Bernouilli(12)
% 
% Unknown Bernouilli number!
% 
% ans =
% 
%     0.1667
% 
% 
% ans =
% 
%    -0.0333
% 
% 
% ans =
% 
%    -0.2531

% 4.
disp('Problem 4')
% Input: s = 2m = 8
% Output: Smallest k where difference of Riemann Zeta Functions is less
% than 10^-10
m = 4; s = m * 2;
k = 1;
while abs(RiemannZetaFunction_Even(m) - RiemannZetaFunction(s,k)) > 10^-10
    k = k + 1;
end
% Test Function
k

% 5.
disp('Problem 5')
disp('See plot')
% Input: k = 1 to 20, s = 2*m = 12
% Output: Plot of difference between two Riemann Zeta Functions
m = 6; s = m * 2;
rze = RiemannZetaFunction_Even(m);
k = 1:20; rz = k; y = k;
for a = 1:20
    rz(a) = RiemannZetaFunction(s,a);
    y(a) = rze - rz(a);
end
plot (k,y,'r*')
xlabel('k');
ylabel('Difference of Riemann Zeta Functions');
title('Riemann Zeta Functions');

end

% ----- Sample Output -----
% Problem 1
% 
% RZFs3k6 =
% 
%     1.1903
% 
% Problem 2
% 
% fact5 =
% 
%    120
% 
% Problem 3
% 
% RZF_E3 =
% 
%     1.0173
% 
% Problem 4
% 
% k =
% 
%     20
% 
% Problem 5
% See plot