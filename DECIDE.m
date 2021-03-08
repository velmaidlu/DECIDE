%% Intermediary variables
CMV = zeros(15, 1);
PUM = zeros(15, 15);
FUV = zeros(15, 0);

CMV(1) = lic0(ARRAY, NUMPOINTS, LENGTH1);

%% LIC 0
function out = lic0(ARRAY, NUMPOINTS, LENGTH1)
out = 0;
    for i = 1:(NUMPOINTS - 1)
        if (norm(ARRAY(i, :)) > LENGTH1) && (norm(ARRAY(i + 1, :)) > LENGTH1)
            out = 1;
        end
    end
end
%% LIC 2

%% LIC 3