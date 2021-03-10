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
