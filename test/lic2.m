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