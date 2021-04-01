function out = lic2(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
epsilon = PARAMETERS.EPSILON;
    for i = 1:(NUMPOINTS - 2)
        coordinate_difference_1 = POINTS(i, :) - POINTS(i + 1, :);
        v2 = POINTS(i + 2, :) - POINTS(i + 1, :);
        if (norm(coordinate_difference_1) == 0) || (norm(v2) == 0) % Checks if the first or third points coincides with the second
            
        else
            angle = abs(acos(dot(coordinate_difference_1, v2) / (norm(coordinate_difference_1) * norm(v2)))); % 0 <= Angle <= pi, so only one condition is enough
            if angle < (pi - epsilon)
                out = 1;
            end
        end
    end
end
