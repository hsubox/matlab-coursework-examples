function [value, isd, dir] = ReactorEvents(t,Y,P,K)
%
% Prepared by Herb Swain
% Transcribed by Kristie Stoneman
%
% This function stops the ode45 integration of the differential equations
% in the file, reactions.m, when the temperature in the reactor reaches the
% ReactorCoolTemp(C).
% It is called by the function, Reactor.m, which simulates the Batch
% Reactor.
%
% 
global ReactorCoolTemp
%
% Check if the reactor temperature has reached the final temperature,
% ReactorCoolTemp(C).
value = Y(10)-(ReactorCoolTemp+273);
%
isd = 1; % This switch determines whether ode45 stops once it reaches the 'event'.
%         'event' is given by the value of the variable, 'value' (see
%         previous line. Since we'd like it to stop, we'll set this to 1,
%         impling that the switch is ON.
%
dir = -1; % This switch determines the direction from which we approach our zero.
% Since we want to detect cooling, we will set it to -1 to detect when it
% has cooled to ReactorCoolTemp.
end