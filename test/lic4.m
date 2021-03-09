function out = lic4(POINTS, NUMPOINTS, PARAMETERS)
out = 0;
q_pts = PARAMETERS.Q_PTS;
quads = PARAMETERS.QUADS;
    for i = 1:(NUMPOINTS + 1 - q_pts)
        Q = zeros(1, 4);
        for j = 0:(q_pts - 1)
            v = POINTS(i + j, :);
            if (v(1) >= 0) && (v(2) >= 0) % Test for quadrant I
                Q(1) = 1;
            end
            if (v(1) < 0) && (v(2) >= 0) % Test for quadrant II
                Q(2) = 1;
            end
            if (v(1) <= 0) && (v(2) < 0) % Test for quadrant III
                Q(3) = 1;
            end
            if (v(1) > 0) && (v(2) < 0) % Test for quadrant IV
                Q(4) = 1;
            end
        end
        if (sum(Q) > quads)
            out = 1;
        end
    end
end
