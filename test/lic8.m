%% LIC 8
function out = lic8(POINTS, NUMPOINTS, PARAMETERS);
out = 0;
a_pts = PARAMETERS.A_PTS;
b_pts = PARAMETERS.B_PTS;
r1 = PARAMETERS.RADIUS1;
    if NUMPOINTS < 5
        return
    end
    for i = 1:(NUMPOINTS - (a_pts + b_pts + 2))
        p1 = POINTS(i, :);
        p2 = POINTS(i + a_pts + 1, :);
        p3 = POINTS(i + a_pts + b_pts + 2);
        if (norm(p1) > r1) || (norm(p2) > r1) || (norm(p3) > r1)
            out = 1;
        end
    end
end