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

%% Test 1: LIC 1 not contained within a circle 

% Test intention : if we plot the first 3 points it is obvious that they 
% can be contained within a circle of the raduis smaller than ~7 (the circumradius of the traingle made by the first 3 points is ~7)
%so obviously they can not be contained within or on a circle of the radius= 5, so we expect
%the LIC 1 would be met with these inputs.

PARAMETERS.RADIUS1=5;

%Test Oracle : we are sure that there exists at least one set ( the first 3
%points) of 3 consecutive data point in POINTS that can not be
%contained within or on a circle of the radius=5, so LIC1 should be met and
%the output of the lic1 should be out=1;

out = lic1(POINTS, NUMPOINTS, PARAMETERS.RADIUS1);
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

%% Test 3: LIC 3 Area of the traingle > AREA1   

% Test intention : check that if the output of the lic3 is 0
% when all the points are close to each other such that the area
% of the triangle made by 3 consecutive points could not be greater
% than AREA1
POINTS= [0 0 ; 1 1; 1 0 ; 0 1; 0.5 0.5; 1 0.5 ; 0.5 1 ; 0 0.5; 0.5 0; 0.25 0.25];
PARAMETERS.AREA1= 1;

% Test Oracle : the points are all within a squre of the area=1,
% so we expect the LIC 3 would not be met and its output : out=0;

out=lic3(POINTS,NUMPOINTS,PARAMETERS.AREA1);
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

%% TEST 5: LIC 5 X[j] - X[i] < 0 (where i=j-1)

% Test intension : check that the output is 1 if we have (more than) one 
% set of 2 consecutive points that the x cordinate of the second of is
% smaller than the first one

% Test Oracle : the x cordinate of 2nd point is greater than point 3rd, 3rd than 4th 
% 6th than 7th, 7th than 8th. so the condition of the lic5 is met and 
% the expected output should be out=1;
out=lic5(POINTS,NUMPOINTS);
assert(out==1)

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

%% Test 6.2: LIC 6 first and last points identical check

% Test intention: check that the output is 1 if at least one of the mid +
% end N_PTS points end up outside a circle of radius DIST around the
% start = end point (by assumption)

POINTS = [1 0; 5 0; 1 0];
NUMPOINTS = 3;
PARAMETERS.N_PTS = 3;
PARAMETERS.DIST = 2;

% Test oracle: The second point (5, 0) is 4 units > 2 units = DIST away
% from the start = end point at (1, 0), and so we expect LIC 6 to output true (1)

out = lic6(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1);

%% TEST 7: LIC 7 check the distance between K_PTS apart points

% Test intention : check that the output is 1 if the distance between 
% 2 data points that are k_PTS apart from each other is greater than LENGTH1

PARAMETERS.K_PTS = 5 ;  %% then there is 4 sets of points to check (1,7) (2,8) (3,9) (4,10) 
PARAMETERS.LENGTH1 = 8 ; % the distance between points 3rd and 9th is greater than 8 : [-2 7] [1 -1] 

% Test Oracle : with these inputs, there exists a set of 2 data points
% seperated by K_PTS point that their distance is greater than LENGTH1. 
% so the expected output of the lic7 is out=1;
out = lic7(POINTS,NUMPOINTS,PARAMETERS.K_PTS,PARAMETERS.LENGTH1);
assert(out == 1)

%% Test 8: LIC 8 three data point separated by intervening points not contained within circle check

% Test intention: check that the output is 1 if at least one of the three
% data points separated by A_PTS and B_PTS consecutive intervening points,
% respectively, ends up outside a circle of radius RADIUS1

POINTS = [1 0; -3 0; 1 0; 5 0; 0 -4; -1 1];
NUMPOINTS = 6;
PARAMETERS.A_PTS = 2;
PARAMETERS.B_PTS = 1;
PARAMETERS.RADIUS1 = 4.5;

% Test oracle: The fourth point (5, 0) (A_PTS away from the first and B_PTS away from the last) 
% is 5 units away from the origin. Hence it lies outside a circle of radius 4.5, and so we expect LIC 8 to output true (1) 

out = lic8(POINTS, NUMPOINTS, PARAMETERS);
assert(out == 1);

%% TEST 9.1 : LIC 9  finding an angle generated by 3  non-consecutive points which is not in the range [pi-EPSILON,pi+EPSILON]

% Test intention : check that the output is 1 if there is one set of 3
% points seperated by C_PTS,D_PTS that form an angle which is not in the
% range of [pi-EPSILON,pi+EPSILON]

PARAMETERS.C_PTS=1;
PARAMETERS.D_PTS=2;
PARAMETERS.EPSILON= 0.1; 

% TEST Oracle :  the angle between points 1, 3 ,and 6 is less than 
% pi-EPSILON. so the condition of the LIC 9 is met for these inputs 
% and the expected output should be out=1;

out=lic9(POINTS,NUMPOINTS,PARAMETERS.C_PTS,PARAMETERS.D_PTS,PARAMETERS.EPSILON);
assert(out == 1)

%% TEST 9.2: LIC9 check the case when all angles are in the range [pi-EPSILON,pi+EPSILON]

%Test intension : we set the epsilon such that there does not exist 
% any angle outside of the range [pi-EPSILON,pi+EPSILON], check that the
% out put is 0
PARAMETERS.EPSILON= pi;
PARAMETERS.C_PTS=1;
PARAMETERS.D_PTS=2;

% Test Oracle : since the unwanted range is now the whole [0,2pi], so all
% of the angles generated by 3 specified points are inside of this range and 
% the condition of the lic9 can not be satisfied and the expected output
% should be 0
out=lic9(POINTS,NUMPOINTS,PARAMETERS.C_PTS,PARAMETERS.D_PTS,PARAMETERS.EPSILON);
assert(out == 0)

%% TEST 11.1: LIC 11 X[j] - X[i] < 0 (where i=j-1) for non-consecutive points

%Test intension: check that the output is 1 if there exists a set of 2 points 
% seperated by G_PTS such that the x-cordinate of the first point is greater
% than the second one's

PARAMETERS.G_PTS = 1;

%Test Oracle : point 1 and 3 are G_PTS seperated of each other and x of point 1 is greater than x of point 3
% so the condition of the LIC11 is satisfied by this set of points and the
% expected output should be out=1

out=lic11(POINTS,NUMPOINTS,PARAMETERS.G_PTS);
assert(out==1)

%% TEST 11.2 : 

%Test intension: check that the output is 0 if all the set of points 
%seperated by G_PTS are such that the x-cordinate of the fist point is
%less than the second point's
PARAMETERS.G_PTS= 9 ;
% Test Oracle: with this G_PTS there is only one set of data points G_PTS
% points apart which is point 1 and 10 where the x of point 1 is less than
% the x of the point 10 1<3. so the expected output  should be 0
out=lic11(POINTS,NUMPOINTS,PARAMETERS.G_PTS);
assert(out==0)
