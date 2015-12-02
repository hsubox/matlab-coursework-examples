function HW_13

% Jennifer Hsu
% 04/14/2011

% clear home screen
clear;
clc;
clf;

% i. ----------------------------------------------------------------------
% Reads data from M1.xlsx file
[M1,~,~] = xlsread('M1.xlsx','Sheet1','A1:B20');
tvec = M1(:,1);
len = length(tvec);
zvec1 = M1(:,2);
ones = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];

% Calculates linear regression for data z = z0 - k*t
% z0 = (sum(zvec) + k*sum(tvec)) / len;
% -k = (sum(tvec.*zvec1) - z0*sum(tvec)) / sum(tvec.^2);
%     A        *          x    = b
% [ ones      tvec    ] * [z0] = [ z_mean   ]
% [                   ]   [-k] = [          ]

A_1 = [ones tvec];
b_1 = zvec1;
x_1 = A_1\b_1;

% Plot of data and fit on the same graph
figure(1);
clf;
hold on;
scatter(tvec, zvec1);
t_1 = linspace(0,7);
z_1 = x_1(1) + (x_1(2).*t_1);
plot(t_1,z_1);
xlabel('t');
ylabel('ln(C(t))');
title('Fit of 1 Experimental Data to Irreversible Reaction Model');

fprintf('i. z0 = %f, k = %f\n', x_1(1), -1*x_1(2));
disp('   See Figure 1.')
disp('   The fit looks OK by eyeball..');

% ii. ---------------------------------------------------------------------
% Reads data from M2.xlsx file
[M2,~,~] = xlsread('M2.xlsx','Sheet1','A1:C20');
% Appends new trials to previous trials
zvec = [zvec1 M2];
[~,n_exp] = size(zvec);

% Calculates the z_mean, variance, and sigma_mean for each time point
for i = 1:len
    z_mean(i,1) = mean(zvec(i,:));
    var(i,1) = sum((zvec(i,:) - z_mean(i,1)).^2)/(n_exp - 1);
    sigma_mean(i,1) = sqrt(var(i,:)/n_exp);
end

% % Calculates linear regression for data z = z0 - k*t
A_2 = [ones./sigma_mean tvec./sigma_mean];
b_2 = z_mean ./ sigma_mean;
x_2 = A_2\b_2;

% Plot of data and fit on the same graph
figure(2);
clf;
hold on;
scatter(tvec, z_mean);
t_2 = linspace(0,7);
z_2 = x_2(1) + (x_2(2).*t_2);
plot(t_2,z_2);
xlabel('t');
ylabel('ln(C(t))');
title('Fit of 4 Experimental Data to Irreversible Reaction Model');

fprintf('ii. z0 = %f, k = %f\n', x_2(1), -1*x_2(2));
disp('   See Figure 2.')

w = (1./sigma_mean).^2;
t_avg = sum(tvec.*w)/sum(w);
t2_avg = sum((tvec.^2).*w)/sum(w);
delta_k = sqrt(2.3/(sum(w)*(t2_avg-t_avg.^2)));
fprintf('   delta_k = %f\n', delta_k);

figure(3);
clf;
hold on;
z_model = x_2(1) + (x_2(2).*tvec);
scatter(tvec, z_mean - z_model);
plot(tvec, -1*sigma_mean);
plot(tvec, sigma_mean);
xlabel('t');
ylabel('Residual');
% There is a clear curve pattern to the residuals. If this was a good
% model, the points would appear to be 'random'. Therefore, this is not a
% good model.
% The deviations of the fit from the mean data are similar in magnitude to
% the expected variance of the mean, but go outside of the sigmas. We 
% have a "okay" fit.
disp('   See Figure 3. Additional comments in  code.')

% iii. --------------------------------------------------------------------
% Reads data from M2.xlsx file
[M3,~,~] = xlsread('M3.xlsx','Sheet1','A1:CS20');
% Appends new trials to previous trials
zvec = [zvec1 M3];
[~,n_exp] = size(zvec);

% Calculates the z_mean, variance, and sigma_mean for each time point
for i = 1:len
    z_mean(i,1) = mean(zvec(i,:));
    var(i,1) = sum((zvec(i,:) - z_mean(i,1)).^2)/(n_exp - 1);
    sigma_mean(i,1) = sqrt(var(i,:)/n_exp);
end

% Calculates linear regression for data z = z0 - k*t
A_3 = [ones./sigma_mean tvec./sigma_mean];
b_3 = z_mean ./ sigma_mean;
x_3 = A_3\b_3;

% Plot of data and fit on the same graph
figure(4);
clf;
hold on;
scatter(tvec, z_mean);
t_3 = linspace(0,7);
z_3 = x_3(1) + (x_3(2).*t_3);
plot(t_3,z_3);
xlabel('t');
ylabel('ln(C(t))');
title('Fit of 101 Experimental Data to Irreversible Reaction Model');

fprintf('iii. z0 = %f, k = %f\n', x_3(1), -1*x_3(2));
disp('   See Figure 4.');

w = (1./sigma_mean).^2;
t_avg = sum(tvec.*w)/sum(w);
t2_avg = sum((tvec.^2).*w)/sum(w);
delta_k = sqrt(2.3/(sum(w)*(t2_avg-t_avg.^2)));
fprintf('   delta_k = %f\n', delta_k);

figure(5);
clf;
hold on;
z_model = x_2(1) + (x_2(2).*tvec);
scatter(tvec, z_mean - z_model);
plot(tvec, -1*sigma_mean);
plot(tvec, sigma_mean);
xlabel('t');
ylabel('Residual');
disp('   See Figure 5.');
% There is a clear curve pattern to the residuals. If this was a good
% model, the points would appear to be 'random'. Therefore, this is not a
% good model.
% The model also does not have a good fit. The deviations of the fit from 
% the mean data are larger in magnitude to the expected variance of the 
% mean.

% iv. ---------------------------------------------------------------------
% C_eq = k_r*C_o/(k+k_r);
% k_r = C_eq*k / (C_o - C_eq);
% z_improved = ln(C_eq+((C_o-C_eq)*exp(-(k+k_r)*t)));
% C_t = exp(z_improved);

% z(t) = ln(C(t));
% zo = ln(Co);

params_0(1) = exp(x_3(1)); % Initial guess of C_o
params_0(2) = -1*x_3(2); % Initial guess of k
C_eq = exp(-2.3);
% k_r = C_eq*k / (C_o - C_eq); % Initial guess of k_r
params_0(3) = C_eq*params_0(2) / (params_0(1) - C_eq);

z_exp = z_mean;

[parameters] = lsqnonlin(@resids, params_0, [.8,0.25,-1], [1.2,0.35,1], [optimset('Display','iter','TolFun', 1e-30)]);

    function resid = resids(params_0)
        C_o = params_0(1);
        k = params_0(2);
        k_r = params_0(3);
        
        C_eq = k_r*C_o/(k+k_r);
        z_improved = log(C_eq+((C_o-C_eq).*exp(-(k+k_r).*tvec)));
        
        resid = z_exp - z_improved;
    end

C_o_f = parameters(1);
k_f = parameters(2);
k_r_f = parameters(3);
C_eq_f = k_r_f*C_o_f/(k_f+k_r_f);
fprintf('iv. C_o = %f, k = %f, k_r = %f, C_eq = %f\n', C_o_f, k_f, k_r_f, C_eq_f);

figure(6);
clf;
hold on;
scatter(tvec, z_mean);
t_4 = linspace(0,7);
z_4 = log(C_eq_f+((C_o_f-C_eq_f).*exp(-(k_f+k_r_f).*t_4)));
plot(t_4,z_4);
xlabel('t');
ylabel('ln(C(t))');
title('Fit of 101 Experimental Data to Reversible Reaction Model');
disp('   See Figure 6.');

figure(7);
clf;
hold on;
z_model = log(C_eq_f+((C_o_f-C_eq_f).*exp(-(k_f+k_r_f).*tvec)));
scatter(tvec, z_mean - z_model);
plot(tvec, -1*sigma_mean);
plot(tvec, sigma_mean);
xlabel('t');
ylabel('Residual');
title('Residuals of 101 Experimental Data to Reversible Reaction Model');
disp('   See Figure 7.');
disp('Additional comments found in code!');
% C_o = 0.998754, k = 0.343173, k_r = 0.006371, C_eq = 0.01820

end


% Output: -----------------------------------------------------------------
% i. z0 = -0.025249, k = 0.329072
%    See Figure 1.
%    The fit looks OK by eyeball..
% ii. z0 = -0.008376, k = 0.335254
%    See Figure 2.
%    delta_k = 0.001882
%    See Figure 3. Additional comments in  code.
% iii. z0 = -0.007009, k = 0.333715
%    See Figure 4.
%    delta_k = 0.000523
%    See Figure 5.
% iv. C_o = 0.998754, k = 0.343173, k_r = 0.006371, C_eq = 0.018205
%    See Figure 6.
%    See Figure 7.
% Additional comments found in code!