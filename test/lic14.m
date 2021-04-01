%% LIC 14
function out = lic14(POINTS, NUMPOINTS, PARAMETERS);
out1 = 0;
out2 = 0;
e_pts = PARAMETERS.E_PTS;
f_pts = PARAMETERS.F_PTS;
area_1 = PARAMETERS.AREA1;
area_2 = PARAMETERS.AREA2;
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
        area = area_of_vectors(v1, v2);
        if area > area_1
            out1 = 1;
        end
        if area < area_2
            out2 = 1;
        end
    end
out = out1*out2;
end

function area = area_of_vectors(vector_1, vector_2)
    area = norm(cross(vector_1, vector_2))/2;
end
