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