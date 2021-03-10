%% LIC 1

% There exists at least one set of three consecutive data points that cannot all be contained
% within or on a circle of radius RADIUS1

function out = lic1(POINTS, NUMPOINTS, RADIUS1)
out = 0;
        for i=1:(NUMPOINTS - 2)
            length_12= sqrt((POINTS(i,1)-POINTS(i+1,1))^2 + (POINTS(i,2)-POINTS(i+1,2))^2 );     
            length_13= sqrt((POINTS(i,1)-POINTS(i+2,1))^2 + (POINTS(i,2)-POINTS(i+2,2))^2 );
            length_23= sqrt((POINTS(i+1,1)-POINTS(i+2,1))^2 + (POINTS(i+1,2)-POINTS(i+2,2))^2 );
            
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