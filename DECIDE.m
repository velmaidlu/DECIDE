
%% Inputs 
PARAMETERS= struct('LENGTH1',1,'RADIUS1',1,'EPSILON',1,'AREA1',1,'Q_PTS',1,'QUADS',1,'DIST',1,'N_PTS',1,'K_PTS',1,'A_PTS',1,'B_PTS',1,'C_PTS',1,'D_PTS',1,'E_PTS',1,'F_PTS',1,'G_PTS',1,'LENGTH2',1,'RADIUS2',1,'AREA2',1);
NUMPOINTS= 100;
POINTS = zeros(NUMPOINTS,2);
PUV = zeros(15,1);
LCM= randi(3,15); %% 1= ANDD , 2=ORR , 3=NOTUSED

%% OUTPUT 
LAUNCH =0;

%% Intermediary variables
CMV = zeros(15, 1);
PUM = zeros(15, 15);
FUV = zeros(15, 1);
%%


CMV(1) = lic0(POINTS, NUMPOINTS, PARAMETERS);
CMV(2) = lic1(POINTS, NUMPOINTS, PARAMETERS.RADIUS1);
CMV(3) = lic2(POINTS, NUMPOINTS, PARAMETERS);
CMV(4) = lic3(POINTS,NUMPOINTS,PARAMETERS.AREA1); 
CMV(5) = lic4(POINTS, NUMPOINTS, PARAMETERS);
CMV(6) = lic5(POINTS,NUMPOINTS);
CMV(7) = lic6(POINTS, NUMPOINTS, PARAMETERS);
CMV(8) = lic7(POINTS,NUMPOINTS,PARAMETERS.K_PTS,PARAMETERS.LENGTH1);
CMV(9) = lic8(POINTS, NUMPOINTS, PARAMETERS);
CMV(10)= lic9(POINTS,NUMPOINTS,PARAMETERS.C_PTS,PARAMETERS.D_PTS,PARAMETERS.EPSILON);
CMV(11)= lic10(POINTS, NUMPOINTS, PARAMETERS);
CMV(12)= lic11(POINTS,NUMPOINTS,PARAMETERS.G_PTS);
CMV(13)= lic12(POINTS, NUMPOINTS, PARAMETERS);
CMV(14)= lic13(POINTS,NUMPOINTS,PARAMETERS.A_PTS,PARAMETERS.B_PTS,PARAMETERS.RADIUS1,PARAMETERS.RADIUS2);
CMV(15)= lic14(POINTS, NUMPOINTS, PARAMETERS);

%% form PUM by combining LCM and CMV 
for i=1:15 
    for j=1:15
        if(LCM(i,j) == 3) % NOTUSED
            PUM(i,j)=1;
        elseif(LCM(i,j) == 1) %AND
            if(CMV(i) ==1 && CMV(j) ==1)
                PUM(i,j)=1;
            end
        else % OR 
            if ( CMV(i)==1 || CMV(j)==1)
                PUM(i,j)=1;
            end
        end
    end
end

%% Forming FUV based on PUM and PUV
for i=1:15
    if( PUV(i) == 0 || sum(PUM(i,:))==15) %% if all elements in row i of the PUM is true (1) then their sum should be 15
     FUV(i)=1;
    end
end

%% Launch 
if( sum(FUV) == 15) % all elements are True (1)
    LAUNCH = 1;
end

disp('LAUNCH:');
disp(LAUNCH);

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
epsilon = PARAMETERS.EPSILON;
    for i = 1:(NUMPOINTS - 2)
        v1 = POINTS(i, :) - POINTS(i + 1, :);
        v2 = POINTS(i + 2, :) - POINTS(i + 1, :);
        if (norm(v1) == 0) || (norm(v2) == 0) % Checks if the first or third points coincides with the second
            
        else
            angle = abs(acos(dot(v1, v2) / (norm(v1) * norm(v2)))); % 0 <= Angle <= pi, so only one condition is enough
            if angle < (pi - epsilon)
                out = 1;
            end
        end
    end
end

%% LIC 3
function out = lic3(POINTS, NUMPOINTS, AREA1) 
out=0;
 for i=1:(NUMPOINTS - 2)
     % finding the side length of the triangle
     length_12= sqrt((POINTS(i,1)-POINTS(i+1,1))^2 + (POINTS(i,2)-POINTS(i+1,2))^2 );     
     length_13= sqrt((POINTS(i,1)-POINTS(i+2,1))^2 + (POINTS(i,2)-POINTS(i+2,2))^2 );
     length_23= sqrt((POINTS(i+1,1)-POINTS(i+2,1))^2 + (POINTS(i+1,2)-POINTS(i+2,2))^2 );
     %Heron's Formula for the area of a triangle 
     p= (length_12+length_13+length_23)/2;
     Area= sqrt(p*(p-length_12)*(p-length_13)*(p-length_23));
     if (Area>AREA1)
         out=1;
         break;
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

%% LIC 5 
%Return TRUE if there exists at least one set of two consecutive data points where X[j] - X[i] < 0 (where i=j-1)
function out = lic5(POINTS, NUMPOINTS)
out=0;
for i=1:(NUMPOINTS - 1)
    if(POINTS(i,1)>POINTS(i+1,1))
        out=1;
        break;
    end
end

end

%% LIC 6
function out = lic6(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
n_pts = PARAMETERS.N_PTS;
dist = PARAMETERS.DIST;
    for i = 1:(NUMPOINTS + 1 - n_pts)
        v_start = POINTS(i, :);
        v_end = POINTS(i + n_pts - 1, :);
        line = v_end - v_start;
        for j = 1:(n_pts - 1)
            v = POINTS(i + j, :) - v_start;
            if norm(line) == 0 % The case where the start and end points coincide
                if norm(v) > dist
                    out = 1;
                end
            else
                if (norm(v) <= dist) || (norm(v_end - v) <= dist)
                
                else
                    angle = acos(dot(v, line)/(norm(v)*norm(line)));
                    if (angle <= pi/2) && (norm(v)*cos(angle) <= norm(line)) && (norm(v)*sin(angle) <= dist) % Checks if v is in a rectangular box around v_start and v_end
                    
                    else
                        out = 1;
                    end
                end
            end
        end 
    end
end

%% LIC 7
function out= lic7(POINTS,NUMPOINTS,K_PTS,LENGTH1)
out=0;
if (NUMPOINTS>=3)
    for i=1:(NUMPOINTS-1-K_PTS)
        distance = sqrt((POINTS(i,1)-POINTS(i+1+K_PTS,1))^2+(POINTS(i,2)-POINTS(i+1+K_PTS,2))^2);
        if(distance > LENGTH1)
            out=1;
            break;
        end
    end
end
end 

%% LIC 8
function out = lic8(POINTS, NUMPOINTS, PARAMETERS);
out = 0;
a_pts = PARAMETERS.A_PTS;
b_pts = PARAMETERS.B_PTS;
r1 = PARAMETERS.RADIUS1;
    if NUMPOINTS < 5
        return
    end
    for i = 1:(NUMPOINTS - (a_pts + b_pts + 2))
        p1 = POINTS(i, :);
        p2 = POINTS(i + a_pts + 1, :);
        p3 = POINTS(i + a_pts + b_pts + 2);
        if (norm(p1) > r1) || (norm(p2) > r1) || (norm(p3) > r1)
            out = 1;
        end
    end
end

%% LIC 9 
function out = lic9 (POINTS,NUMPOINTS,C_PTS,D_PTS,EPSILON)
out=0;
if( NUMPOINTS>= 5) 
    for i= 1: (NUMPOINTS-2-C_PTS-D_PTS)
        % finding 2 vector corresponding to the 2nd point being vertex
        V21=[POINTS(i+1+C_PTS,1)-POINTS(i,1) ; POINTS(i+1+C_PTS,2)-POINTS(i,2)];
        V23=[POINTS(i+2+C_PTS+D_PTS,1)-POINTS(i+1+C_PTS,1); POINTS(i+2+C_PTS+D_PTS,2)-POINTS(i+1+C_PTS,2)];
        
        % finding the angle using dot product formula
        % V21.V23=|V21||V23|cos a
        if (norm(V21) ~= 0 && norm(V23) ~= 0) % P1 or P3 should not coincide with the vertex P2
            angle=acos(dot(V21,V23)/(norm(V21)*norm(V23)));
            if((angle < (pi-EPSILON)) || ((angle > (pi+EPSILON)) ))
                out=1;
                break;
            end
            
        end       
    end
end

end

%% LIC 10
function out = lic10(POINTS, NUMPOINTS, PARAMETERS);
out = 0;
e_pts = PARAMETERS.E_PTS;
f_pts = PARAMETERS.F_PTS;
a1 = PARAMETERS.AREA1;
    if NUMPOINTS < 5
        return
    end
    for i = 1:(NUMPOINTS - (e_pts + f_pts + 2))
        p1 = POINTS(i, :);
        p2 = POINTS(i + e_pts + 1, :);
        p3 = POINTS(i + e_pts + f_pts + 2);
        v1 = p2 - p1;
        v2 = p3 - p1;
        v1(3) = 0;
        v2(3) = 0;
        area = norm(cross(v1, v2))/2;
        if area > a1
            out = 1;
        end
    end
end

%% LIC 11
function out = lic11(POINTS,NUMPOINTS,G_PTS)
out=0;
if (NUMPOINTS>=3)
    for i= 1: (NUMPOINTS-1-G_PTS)
        if ( POINTS(i,1)> POINTS(i+1+G_PTS,1) )
            out=1;
        end
    end
    
end
end

%% LIC 12
function out = lic12(POINTS, NUMPOINTS, PARAMETERS);
out1 = 0;
out2 = 0;
out = 0;
k_pts = PARAMETERS.K_PTS;
len1 = PARAMETERS.LENGTH1;
len2 = PARAMETERS.LENGTH2;
    if NUMPOINTS < 3
        return
    end
    for i = 1:(NUMPOINTS - (k_pts + 1))
        p1 = POINTS(i, :);
        p2 = POINTS(i + k_pts + 1, :);
        if norm(p2 - p1) > len1 
            out1 = 1;
        end
        if norm(p2 - p1) < len2
            out2 = 1;
        end
    end
out = out1*out2;
end

%% LIC 13
function out = lic13(POINTS,NUMPOINTS,A_PTS,B_PTS,RADIUS1,RADIUS2)
out=0;
out1=0; % a flag for checking the first condition 
if(NUMPOINTS>=5)
    for i=1 :(NUMPOINTS-2-A_PTS-B_PTS) %% checking first condition
        length_12 = sqrt((POINTS(i,1)-POINTS(i+1+A_PTS,1))^2 + (POINTS(i,2)-POINTS(i+1+A_PTS,2))^2 );
        length_13 = sqrt((POINTS(i,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
        length_23 = sqrt((POINTS(i+1+A_PTS,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i+1+A_PTS,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
        
        % finding the circumradius of the traingle with sides length_12, length_13, and length_23
        % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
        radius1= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                 *(length_23+length_12-length_13)*(length_12+length_13-length_23));
        if (radius1 > RADIUS1)
                out1=1;
                break;
        end
    end
    if ( out1 == 1)
        for i=1 :(NUMPOINTS-2-A_PTS-B_PTS) %% checking first condition
            length_12 = sqrt((POINTS(i,1)-POINTS(i+1+A_PTS,1))^2 + (POINTS(i,2)-POINTS(i+1+A_PTS,2))^2 );
            length_13 = sqrt((POINTS(i,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
            length_23 = sqrt((POINTS(i+1+A_PTS,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i+1+A_PTS,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
            
            % finding the circumradius of the traingle with sides length_12, length_13, and length_23
            % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
            radius2= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                *(length_23+length_12-length_13)*(length_12+length_13-length_23));
            if (radius2 <= RADIUS2)
                out=1;
                break;
            end
        end
    end    
end
end

%% LIC 14
function out = lic14(POINTS, NUMPOINTS, PARAMETERS);
out1 = 0;
out2 = 0;
e_pts = PARAMETERS.E_PTS;
f_pts = PARAMETERS.F_PTS;
a1 = PARAMETERS.AREA1;
a2 = PARAMETERS.AREA2;
    if NUMPOINTS < 5
        return
    end
    for i = 1:(NUMPOINTS - (e_pts + f_pts + 2))
        p1 = POINTS(i, :);
        p2 = POINTS(i + e_pts + 1, :);
        p3 = POINTS(i + e_pts + f_pts + 2);
        v1 = p2 - p1;
        v2 = p3 - p1;
        v1(3) = 0;
        v2(3) = 0;
        area = norm(cross(v1, v2))/2;
        if area > a1
            out1 = 1;
        end
        if area < a2
            out2 = 1;
        end
    end
out = out1*out2;
end
