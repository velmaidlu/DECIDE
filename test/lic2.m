function out = lic2(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
epsilon = PARAMETERS.EPSILON;
    for i = 1:(NUMPOINTS - 2)
        coordinate_difference_1 = POINTS(i, :) - POINTS(i + 1, :);
        coordinate_difference_2 = POINTS(i + 2, :) - POINTS(i + 1, :);
        if angle_check(coordinate_difference_1, coordinate_difference_2, epsilon)
            out = 1;
        end
    end
end

function check = angle_check(vector_1, vector_2, epsilon)
    if zero_vector_check(vector_1, vector_2) % Checks if the first or third points coincides with the second
        check = 0;
    else
        angle = angle_between_vectors(vector_1, vector_2); % 0 <= Angle <= pi, so only one condition is enough
        if angle < (pi - epsilon)
            check = 1;
        else
            check = 0;
        end
    end
end

function check = zero_vector_check(vector_1, vector_2)
    check = (norm(vector_1) == 0) || (norm(vector_2) == 0);
end

function angle = angle_between_vectors(vector_1, vector_2)
    angle = abs(acos(dot(vector_1, vector_2) / (norm(vector_1) * norm(vector_2))));
end
