function MaterialsProperties
% 
% 10.10 Project. Spring 2011.
% Prepared by George Stephanopoulos.
% 
% This function assigns the physical properties values of all the
% materials in the process, onto the elements of a matrix and makes the
% matrix available to all other functions as a GLOBAL variable.
%
% The name of the matrix is: Materials_Properties(i,j).
%   The first index signifies a material, i.e.
%       i = 1, signifies reagent, A
%       i = 2, signifies reagent, B
%       i = 3, signifies main product, P
%       i = 4, signifies by-product, Q
%       i = 5, signifies waste, W
%       i = 6, signifies waste, Z
%       i = 7, signifies catalyst, C
%       i = 8, signifies reation solvent, S1
%       i = 9, signifies reation solvent, S2
%   The second index signifies the specific property, i.e.
%       j = 1, molecular weight of the material
%       j = 2, density of the material, kg/m3
%       j = 3, heat capacity of the material, kJ/kg, C
%       j = 4, heat of vaporization of the material, kJ/mole
%       j = 5, heat of fusion of the material, kJ/kg
%       j = 6, boiling point, degrees Kelvin
%
%   INPUT Global Variables. None.
%   OUTPUT Global Variables
%
global Materials_Properties          % This matrix contains the physical properties of all materials in the process
%
% Assign property values for the various materials
%
%   Chemical, A
Materials_Properties(1,1) = 102;
Materials_Properties(1,2) = 1030;
Materials_Properties(1,3) = 4;
Materials_Properties(1,4) = 300;
Materials_Properties(1,6) = 453;
%
%   Chemical, B
Materials_Properties(2,1) = 163.5;
Materials_Properties(2,2) = 720;
Materials_Properties(2,3) = 2;
Materials_Properties(2,4) = 50;
Materials_Properties(2,6) = 450;
%
%   Product, P
Materials_Properties(3,1) = 459;
Materials_Properties(3,2) = 1000;
Materials_Properties(3,3) = 2;
Materials_Properties(3,4) = 100;
Materials_Properties(3,5) = 350;
Materials_Properties(3,6) = 430;
%
%   By-product, Q
Materials_Properties(4,1) = 133.5;
Materials_Properties(4,2) = 1000;
Materials_Properties(4,3) = 2;
Materials_Properties(4,4) = 150;
Materials_Properties(4,6) = 460;
%
%   Waste, W
Materials_Properties(5,1) = 918;
Materials_Properties(5,2) = 1000;
Materials_Properties(5,3) = 2.5;
Materials_Properties(5,4) = 200;
Materials_Properties(5,6) = 470;
%
%   Waste, Z
Materials_Properties(6,1) = 1377;
Materials_Properties(6,2) = 1000;
Materials_Properties(6,3) = 3;
Materials_Properties(6,4) = 300;
Materials_Properties(6,6) = 420;
%
%   Catalyst, C
Materials_Properties(7,1) = 410;
Materials_Properties(7,2) = 1010;
Materials_Properties(7,3) = 2;
Materials_Properties(7,4) = 100;
Materials_Properties(7,6) = 450;
%
%   Reaction solvent, S1
Materials_Properties(8,1) = 76;
Materials_Properties(8,2) = 1050;
Materials_Properties(8,3) = 4.184;
Materials_Properties(8,4) = 120;
Materials_Properties(8,6) = 430;
%
%   Extraction solvent, S2
Materials_Properties(9,1) = 170;
Materials_Properties(9,2) = 868;
Materials_Properties(9,3) = 2;
Materials_Properties(9,4) = 200;
Materials_Properties(9,6) = 490;


end