%% LIC 10
function out = lic10(POINTS, NUMPOINTS, PARAMETERS);
out = 0;
e_pts = PARAMETERS.E_PTS;
f_pts = PARAMETERS.F_PTS;
a1 = PARAMETERS.AREA1;
    if NUMPOINTS < 5
        return
    end
    for i = 1:(NUMPOINTS - (e_pts + f_pts + 2))
        p1 = POINTS(i, :);
        p2 = POINTS(i + e_pts + 1, :);
        p3 = POINTS(i + e_pts + f_pts + 2);
        v1 = p2 - p1;
        v2 = p3 - p1;
        v1(3) = 0;
        v2(3) = 0;
        area = norm(cross(v1, v2))/2;
        if area > a1
            out = 1;
        end
    end
end