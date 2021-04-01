%% LIC 0
function out = lic0(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
min_distance = PARAMETERS.LENGTH1;
    for i = 1:(NUMPOINTS - 1)
        coordinate_1 = POINTS(i, :);
        coordinate_2 = POINTS(i + 1, :);
        if (norm(coordinate_1 - coordinate_2) > min_distance)
            out = 1;
        end
    end
end
