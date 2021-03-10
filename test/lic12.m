%% LIC 12
function out = lic12(POINTS, NUMPOINTS, PARAMETERS);
out1 = 0;
out2 = 0;
out = 0;
k_pts = PARAMETERS.K_PTS;
len1 = PARAMETERS.LENGTH1;
len2 = PARAMETERS.LENGTH2;
    if NUMPOINTS < 3
        return
    end
    for i = 1:(NUMPOINTS - (k_pts + 1))
        p1 = POINTS(i, :);
        p2 = POINTS(i + k_pts + 1, :);
        if norm(p2 - p1) > len1 
            out1 = 1;
        end
        if norm(p2 - p1) < len2
            out2 = 1;
        end
    end
out = out1*out2;
end
