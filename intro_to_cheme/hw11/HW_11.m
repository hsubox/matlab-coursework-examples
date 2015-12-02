function HW_11
% Author: Jennifer Hsu
% Created: 03/15/2011

% clear command window
clear
clc

format longG;

% 1.
% % Function below this function
% % Test code
% M = [1 2 3; 4 5 6; -1 0 -1];
% Q = swap_rows(M, 1, 2)
% % Q =
% % 
% %      4     5     6
% %      1     2     3
% %     -1     0    -1
% 
% 2.
% % Function below this function
% % Test code
% out = randint(5,5,[-100,100])
% % out =
% % 
% %    -30   -30   -43   -85   -74
% %    -61    66    52   -90    14
% %    -50    17    51     6    -6
% %     23    10   -24    56   -98
% %     -5    84    14    87   -33
% biggest_element_row(out,1)
% % J =
% % 
% %      2
% % 
% % 
% % ans =
% % 
% %      2
% biggest_element_row(out,2)
% % J =
% % 
% %      5
% % ans =
% % 
% %      5
% biggest_element_row(out,3)
% % ans =
% % 
% %      3

% 3.
% Function below this function

% 4.
% Function below this function

% 5.
% Read in Excel File Data:
A_HW09 = xlsread('HW09','Sheet1','C2:AX49');
b_HW09 = xlsread('HW09','Sheet1','AZ2:AZ49');

x = myGaussSolver(A_HW09,b_HW09)
x_HW09 = A_HW09\b_HW09

% Output by myGaussSolver and backslash function give same solution
% x =
% 
%          0.105365787452919
%         0.0799535284216754
%         0.0254122590312438
%        0.00323227853472496
%         0.0767212498869504
%          0.236628306730301
%           0.14517224123731
%        0.00177775319409877
%         0.0066877382063719
%         0.0066877382063719
%          0.145500153508929
%      4.68441814595658e-006
%         0.0799488440035294
%          0.236300394458683
%          0.145500153508929
%      4.68441814595658e-006
%         0.0799488440035293
%         0.0144069033344222
%        0.00668773820637292
%          0.236300394458673
%          0.888939579154092
%          0.125353648896543
%          0.888939579154092
%           0.22189349112426
%          0.125353648896552
%          0.888939579154092
%           0.22189349112426
%          0.187555783455796
%         0.0498566006654649
%        0.00453241824231499
%          0.194243521662169
%          0.210731574905838
%          0.105365787452919
%           18.1287691851122
%            11.035563746079
%           0.96223322360926
%           23.7168634820177
%                         30
%         0.0726850258378867
%        0.00726850258378867
%        0.00403622404906364
%        0.00322759411657907
%       0.000327912271618458
%           0.22189349112426
%           0.22189349112426
%         0.0254122590312439
%      4.68441814595658e-006
%         0.0144069033344222
% 
% 
% x_HW09 =
% 
%          0.105365787452919
%         0.0799535284216754
%         0.0254122590312438
%        0.00323227853472506
%         0.0767212498869504
%          0.236628306730301
%           0.14517224123731
%        0.00177775319409873
%         0.0066877382063719
%         0.0066877382063719
%          0.145500153508928
%      4.68441814595658e-006
%         0.0799488440035294
%          0.236300394458683
%          0.145500153508928
%      4.68441814595658e-006
%         0.0799488440035294
%         0.0144069033344223
%        0.00668773820637281
%          0.236300394458673
%          0.888939579154092
%          0.125353648896542
%          0.888939579154092
%           0.22189349112426
%          0.125353648896552
%          0.888939579154092
%           0.22189349112426
%          0.187555783455796
%         0.0498566006654648
%        0.00453241824231498
%          0.194243521662169
%          0.210731574905838
%          0.105365787452919
%           18.1287691851122
%            11.035563746079
%          0.962233223609244
%           23.7168634820177
%                         30
%         0.0726850258378867
%        0.00726850258378867
%        0.00403622404906364
%        0.00322759411657908
%       0.000327912271618389
%           0.22189349112426
%           0.22189349112426
%         0.0254122590312438
%      4.68441814595658e-006
%         0.0144069033344223

% 6.
A = [1 2 3; 4 5 6; -1 0 -1];
B=[1 2 3; 4 5 6; 5 7 9];
b= [1; 1; 0];
d = [1; 0; 1];

% w,x,y,z found using myGaussSolver function
% w,x are normal results
% y,z are singular because B is not independent set of vectors
w = myGaussSolver(A,b)
% w =
% 
%                       -0.5
%                          0
%                        0.5
x = myGaussSolver(A,d)
% x =
% 
%          -1.33333333333333
%          0.666666666666667
%          0.333333333333333
y = myGaussSolver(B,b)
% matrix U is singular
% 
% y =
% 
%      0
%      0
%      0
z = myGaussSolver(B,d)
% matrix U is singular
% 
% z =
% 
%      0
%      0
%      0


% w,x,y,z found using backslash
% w,x are normal results
% y,z give errors i.e. "close to singular"
w = A\b
% w =
% 
%                       -0.5
%                          0
%                        0.5
x = A\d
% x =
% 
%          -1.33333333333333
%          0.666666666666667
%          0.333333333333333
y = B\b
% Warning: Matrix is close to singular or badly scaled.
%          Results may be inaccurate. RCOND = 1.541976e-017. 
% > In HW_11 at 142
% 
% y =
% 
%       1.8014398509482e+015
%     -3.60287970189639e+015
%       1.8014398509482e+015
z = B\d
% Warning: Matrix is close to singular or badly scaled.
%          Results may be inaccurate. RCOND = 1.541976e-017. 
% > In HW_11 at 143
% 
% z =
% 
%         -0.866666666666667
%         -0.266666666666667
%                        0.8

rank_Ab = rank([A b])
% rank_Ab =
% 
%      3
% Normal solvable system
rank_Ad = rank([A d])
% rank_Ad =
% 
%      3
% Normal solvable system
rank_Bb = rank([B b])
% rank_Bb =
% 
%      3
% System contains two parallel equation -> no solution
rank_Bd = rank([B d])
% rank_Bd =
% 
%      2
% System has redundant equations -> infinite solutions

end

% Code for 1. ------------------------------------------------------------
function Q = swap_rows(M,J,N)

% Author: Jennifer Hsu
% Created: 03/15/2011

% swaps rows M(N,:) and M(J,:).
% input: M is a matrix
% J,N are counting numbers
% output: Q is a matrix, same dimensions as M

% sets Q equal to matrix M
Q = M;

% swaps rows N and J from M into Q
Q(N,:) = M(J,:);
Q(J,:) = M(N,:);

end

% Code for 2. ------------------------------------------------------------
function J = biggest_element_row(M,N)

% Author: Jennifer Hsu
% Created: 03/15/2011

% looks for the largest magnitude number in the column below M(N,N).
% If the largest magnitude number is in row M(J,:) and |M(J,N)|>|M(N,N)| returns J.
% Otherwise, returns N.
% input: M is a matrix with more than N rows and at least N columns
% N is a counting number, the index of the special row and column
% output: J is a counting number, the index of the row with the biggest element in
% the column headed by M(N,N).

% Finds # of rows and columns in matrix M
[rows,cols] = size(M);

% Checks minimum conditions of inputs
if (rows < N)
    disp('Less than N rows');
else if (cols < N)
        disp('Less than N rows');
    end
end

% largest element's index
% initially set to have value equal to N
J = N;

% goes through each 
for x = N:rows
    if abs(M(J,N)) < abs(M(x,N))
        J = x;
    end
end

end

% Code for 3. ------------------------------------------------------------
function [U, v] = reduce_to_triangular(A,b)

% Author: Jennifer Hsu
% Created: 03/15/2011

% reduces square system of linear equations A*x=b to upper triangular form U*x=v
% inputs: A is a square matrix, b is a column vector of the same dimension
% outputs: U is a square matrix, same dimension as A, whose lower
% triangular entries are all zero; v is a column vector of the same
% dimension

% Augment matrices
U = [A b];

% finds dimensions of U
[rows,cols] = size(U);

% for each column (<= # rows) of matrix find the largest element and place 
% its row at the top
for N = 1:rows
    J = biggest_element_row(U,N);
    U = swap_rows(U,N,J);
    % for each row below current (N), get multiply and add to get rid of
    % leading coefficients
    for x = (N+1):rows
        r_factor = U(x,N)/U(N,N);
        U(x,:) = U(x,:) - (r_factor .* U(N,:));
    end
end

% Un-augment matrices
v = U(:,end);
U = U(:,1:end-1);

end

% Code from class -------------------------------------------------------
function x=backsub(U,v)
% solves Ux=v if U is square upper triangular
% inputs:
%     U is NxN upper triangular matrix
%     v is an Nx1 column vector
% output:
%    x is an Nx1 column vector that solves U*x=v
vec=size(U);
% ....check to ensure U is square...
N=vec(1);   % N is the dimension of matrix & vectors
x=zeros(N,1);
if(rank(U)==N)
    for i=1:N
        j=N+1-i;
     x(j,1)= v(j,1)/U(j,j);
     v = v - x(j,1)*U(:,j);
    end
     else
         disp('matrix U is singular');
    end
return
end

% Code for 4. ------------------------------------------------------------
function x = myGaussSolver(A,b)
% solves the linear system of equations A*x = b
% inputs: A must be a square NxN matrix. b is a column vector of length N
% output: x is a column vector of length N that solves A*x=b

% Checks conditions of inputs
[rows_A,cols_A] = size(A);
[rows_b,cols_b] = size(b);
if rows_A ~= cols_A
    disp('Matrix A is not a square');
    return
else if cols_b ~= 1
        disp('b is not a column vector');
        return
    else if rows_b ~= rows_A
            disp('Length of b and size of A do not agree');
            return
        end
    end
end

% Singularity checked by backsub.m

[U, v] = reduce_to_triangular(A,b);
x = backsub(U,v);

end
