%% LIC 9 
%There exists at least one set of three data points separated by exactly C PTS and D PTS
%consecutive intervening points, respectively, that form an angle such
%that the angle is not in the range [pi-EPSILON,pi+EPSILON]
%The second point = vertex of the angle
%The first/third point does not coincide with the second
% NUMPOINTS < 5
function out = lic9 (POINTS,NUMPOINTS,C_PTS,D_PTS,EPSILON)
out=0;
if( NUMPOINTS>= 5) 
    for i= 1: (NUMPOINTS-2-C_PTS-D_PTS)
        % finding 2 vector corresponding to the 2nd point being vertex
        vector_21=[POINTS(i+1+C_PTS,1)-POINTS(i,1) ; POINTS(i+1+C_PTS,2)-POINTS(i,2)];
        vector_23=[POINTS(i+2+C_PTS+D_PTS,1)-POINTS(i+1+C_PTS,1); POINTS(i+2+C_PTS+D_PTS,2)-POINTS(i+1+C_PTS,2)];
        
        % finding the angle using dot product formula
        % V21.V23=|V21||V23|cos a
        if(angle_checker(vector_21,vector_23,EPSILON) ==1)
            out=1;
            break;
        end      
    end
end

end
function angle = angle_finder(vector1,vector2)
angle=acos(dot(vector1,vector2)/(norm(vector1)*norm(vector2))); 
end
function out=angle_checker(vector1,vector2,EPSILON)
out=0;
if (norm(vector1) ~= 0 && norm(vector2) ~= 0) % P1 or P3 should not coincide with the vertex P2
    angle=angle_finder(vector1,vector2);
    if((angle < (pi-EPSILON)) || ((angle > (pi+EPSILON)) ))
        out=1;
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