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

%% Test 4: LIC 4 number of quadrants check

% Test intention: check that the output is 1 if Q_PTS consequtive points
% lie in more than QUADS quadrants

PARAMETERS.Q_PTS = 3;
PARAMETERS.QUADS = 2;

% Test oracle: The Q_PTS consecutive points 4, 5, 6 lie in the second, fourth and first
% quadrant, respectively. Hence, they lie in more than QUADS = 2 quadrants, 
% and so we expect LIC 4 to output true (1)

out = lic4(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1)

%% Test 6.1: LIC 6 distance from line check - normal case

% Test intention: check that the output is 1 if at least one of the mid +
% end N_PTS points end up outside of a line

POINTS = [1 0; 2 5; 3 0];
NUMPOINTS = 3;
PARAMETERS.N_PTS = 3;
PARAMETERS.DIST = 2;

% Test oracle: The second point (2, 5) is 5 units > 2 units = DIST away
% from the line between (1, 0) and (3, 0), and so we expect LIC 6 to output
% true (1)

out = lic6(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1);

