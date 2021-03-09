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
