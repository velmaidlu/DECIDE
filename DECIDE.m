%% Intermediary variables
CMV = zeros(15, 1);
PUM = zeros(15, 15);
FUV = zeros(15, 0);

PARAMETERS= struct('LENGTH1',1,'RADIUS1',1,'EPSILON',1,'AREA1',1,'Q_PTS',1,'QUADS',1,'DIST',1,'N_PTS',1,'K_PTS',1,'A_PTS',1,'B_PTS',1,'C_PTS',1,'D_PTS',1,'E_PTS',1,'F_PTS',1,'G_PTS',1,'LENGTH2',1,'RADIUS2',1,'AREA2',1);    

CMV(1) = lic0(ARRAY, NUMPOINTS, LENGTH1);
CMV(2)=lic1(ARRAY, NUMPOINTS, PARAMETERS.RADIUS1);

%% LIC 0
function out = lic0(ARRAY, NUMPOINTS, LENGTH1)
out = 0;
    for i = 1:(NUMPOINTS - 1)
        if (norm(ARRAY(i, :)) > LENGTH1) && (norm(ARRAY(i + 1, :)) > LENGTH1)
            out = 1;
        end
    end
end

%% LIC 1
function out = lic1(ARRAY, NUMPOINTS, RADIUS1)
out = 0;
        for i=1:(NUMPOINTS - 2)
            length_12= sqrt((ARRAY(i,1)-ARRAY(i+1,1))^2 + (ARRAY(i,2)-ARRAY(i+1,2))^2 );     
            length_13= sqrt((ARRAY(i,1)-ARRAY(i+2,1))^2 + (ARRAY(i,2)-ARRAY(i+2,2))^2 );
            length_23= sqrt((ARRAY(i+1,1)-ARRAY(i+2,1))^2 + (ARRAY(i+1,2)-ARRAY(i+2,2))^2 );
            
            % finding the circumradius of the traingle with sides length_12, length_13, and length_23
            % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
            radius= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                    *(length_23+length_12-length_13)*(length_12+length_13-length_23));
            if (radius > RADIUS1)
                out=1;
                break; %% because the condition is 'at least 1'
            end 
        end 
        
end 
                
            
            
