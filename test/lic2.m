function out = lic2(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
epsilon = PARAMETERS.EPSILON;
    for i = 1:(NUMPOINTS - 2)
        coordinate_difference_1 = POINTS(i, :) - POINTS(i + 1, :);
        coordinate_difference_2 = POINTS(i + 2, :) - POINTS(i + 1, :);
        if (norm(coordinate_difference_1) == 0) || (norm(coordinate_difference_2) == 0) % Checks if the first or third points coincides with the second
            
        else
            angle = angle_between_vectors(coordinate_difference_1, coordinate_difference_2); % 0 <= Angle <= pi, so only one condition is enough
            if angle < (pi - epsilon)
                out = 1;
            end
        end
    end
end

function angle = angle_between_vectors(vector_1, vector_2)
    angle = abs(acos(dot(vector_1, vector_2) / (norm(vector_1) * norm(vector_2))));
end
