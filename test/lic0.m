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