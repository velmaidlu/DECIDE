
%% Inputs 
PARAMETERS= struct('LENGTH1',1,'RADIUS1',1,'EPSILON',1,'AREA1',1,'Q_PTS',1,'QUADS',1,'DIST',1,'N_PTS',1,'K_PTS',1,'A_PTS',1,'B_PTS',1,'C_PTS',1,'D_PTS',1,'E_PTS',1,'F_PTS',1,'G_PTS',1,'LENGTH2',1,'RADIUS2',1,'AREA2',1);
NUMPOINTS= 100;
POINTS = zeros(NUMPOINTS,2);
PUV = zeros(15,1);
LCM= randi(3,15); %% 1= ANDD , 2=ORR , 3=NOTUSED

%% Intermediary variables
CMV = zeros(15, 1);
PUM = zeros(15, 15);
FUV = zeros(15, 0);
%%


CMV(1) = lic0(POINTS, NUMPOINTS, PARAMETERS);
CMV(2)=lic1(POINTS, NUMPOINTS, PARAMETERS.RADIUS1);

CMV(3) = lic2(POINTS, NUMPOINTS, PARAMETERS);

CMV(5) = lic4(POINTS, NUMPOINTS, PARAMETERS);


%% LIC 0
function out = lic0(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
len = PARAMETERS.LENGTH1;
    for i = 1:(NUMPOINTS - 1)
        v1 = POINTS(i, :);
        v2 = POINTS(i + 1, :);
        if (norm(v1 - v2) > len)
            out = 1;
        end
    end
end

%% LIC 1
function out = lic1(POINTS, NUMPOINTS, RADIUS1)
out = 0;
        for i=1:(NUMPOINTS - 2)
            length_12= sqrt((POINTS(i,1)-POINTS(i+1,1))^2 + (POINTS(i,2)-POINTS(i+1,2))^2 );     
            length_13= sqrt((POINTS(i,1)-POINTS(i+2,1))^2 + (POINTS(i,2)-POINTS(i+2,2))^2 );
            length_23= sqrt((POINTS(i+1,1)-POINTS(i+2,1))^2 + (POINTS(i+1,2)-POINTS(i+2,2))^2 );
            
            % finding the circumradius of the traingle with sides length_12, length_13, and length_23
            % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
            radius= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                    *(length_23+length_12-length_13)*(length_12+length_13-length_23));
            if (radius > RADIUS1)
                out=1;
                break; %% because the condition is 'at least 1'
            end 
        end 
        
end

%% LIC 2
function out = lic2(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
PI = PARAMETERS.PI;
epsilon = PARAMETERS.EPSILON;
    for i = 1:(NUMPOINTS - 2)
        v1 = POINTS(i, :) - POINTS(i + 1, :);
        v2 = POINTS(i + 2, :) - POINTS(i + 1, :);
        if (norm(v1) == 0) || (norm(v2) == 0) % Checks if the first or third points coincides with the second
            
        else
            angle = abs(acos(dot(v1, v2) / (norm(v1) * norm(v2)))); % 0 <= Angle <= pi, so only one condition is enough
            if angle < (PI - epsilon)
                out = 1;
            end
        end
    end
end

%% LIC 4
function out = lic4(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
q_pts = PARAMETERS.Q_PTS;
quads = PARAMETERS.QUADS;
    for i = 1:(NUMPOINTS + 1 - q_pts)
        Q = zeros(1, 4);
        for j = 0:(q_pts - 1)
            v = POINTS(i + j, :);
            if (v(1) >= 0) && (v(2) >= 0) % Test for quadrant I
                Q(1) = 1;
            end
            if (v(1) < 0) && (v(2) >= 0) % Test for quadrant II
                Q(2) = 1;
            end
            if (v(1) <= 0) && (v(2) < 0) % Test for quadrant III
                Q(3) = 1;
            end
            if (v(1) > 0) && (v(2) < 0) % Test for quadrant IV
                Q(4) = 1;
            end
        end
        if (sum(Q) > quads)
            out = 1;
        end
    end
end
