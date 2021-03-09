% test input
POINTS = [1 2; 3 1; -2 7; -5 3; 8 -4; 9 1; 1 1; 0 0; 1 -1; 3 5];
NUMPOINTS = 10;

%% Test 0: LIC 0 distance check

% Test intention: check that the output is 1 if the greatest distance
% between two consecutive points > LENGTH1

PARAMETERS.LENGTH1 = 10;

% Test oracle: The greatest distance between two consecutive points is ~15 > LENGTH1 = 10,
% and so we expect LIC 0 to output true (1)

out = lic0(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1)

%% Test 2.1: LIC 2 angle check

% Test intention: check that the output is 1 if the 0 <= angle <= pi is less than pi -
% epsilon, assuming the first/third point does not coincide with the second

PARAMETERS.PI = pi;
PARAMETERS.EPSILON = pi/4;

% Test oracle: The angle between points 7, 8, 9 should be pi/2 < pi -
% epsilon = 3pi/4, and so we expect LIC 2 to output true (1)

out = lic2(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1)

%% Test 2.2: LIC 2 first/third point equal to second check

% Test intention: check that the output is 0 if the first or third point in
% a row equal the second

POINTS = [1 2; 3 1; -2 7; -5 3; 8 -4; 9 1; 1 1; 0 0; 1 -1; 1 -1];
PARAMETERS.PI = pi;
PARAMETERS.EPSILON = pi - 0.01;

% Test oracle: The angles are all greater than pi - epsilon = 0.01, but
% points 8, 9, 10 are such that the second coincides with the third, and so
% we expect LIC 2 to output false (0)

out = lic2(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 0)
