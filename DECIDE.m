%% Intermediary variables
CMV = zeros(15, 1);
PUM = zeros(15, 15);
FUV = zeros(15, 0);

CMV(1) = lic0(POINTS, NUMPOINTS, PARAMETERS);

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

%% LIC 2
