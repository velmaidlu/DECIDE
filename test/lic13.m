%% LIC 13
%There exists at least one set of three data points, separated by exactly A_PTS and B_PTS
%consecutive intervening points, respectively, that cannot be contained within or on a circle of
%radius RADIUS1. In addition, there exists at least one set of three data points (which can be
%the same or different from the three data points just mentioned) separated by exactly A_PTS
%and B_PTS consecutive intervening points, respectively, that can be contained in or on a
%circle of radius RADIUS2
function out = lic13(POINTS,NUMPOINTS,A_PTS,B_PTS,RADIUS1,RADIUS2)
out=0;
out1=0; % a flag for checking the first condition 
if(NUMPOINTS>=5)
    for i=1 :(NUMPOINTS-2-A_PTS-B_PTS) %% checking first condition
        length_12 = sqrt((POINTS(i,1)-POINTS(i+1+A_PTS,1))^2 + (POINTS(i,2)-POINTS(i+1+A_PTS,2))^2 );
        length_13 = sqrt((POINTS(i,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
        length_23 = sqrt((POINTS(i+1+A_PTS,1)-POINTS(i+2+A_PTS+B_PTS,1))^2 + (POINTS(i+1+A_PTS,2)-POINTS(i+2+A_PTS+B_PTS,2))^2 );
        
        % finding the circumradius of the traingle with sides length_12, length_13, and length_23
        % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
        radius1= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                 *(length_23+length_12-length_13)*(length_12+length_13-length_23));
        if (radius1 > RADIUS1)
                out1=1;
                break;
        end
    end
    if ( out1 == 1)
        for i=1 :(NUMPOINTS-2-A_PTS-B_PTS) %% checking first condition
            length_12 = sqrt((POINTS(i,1)-POINTS(i+1+A_PTS,1))^2 + (POINTS(i,2)-POINTS(i+1+A_PTS,2))^2 );
            length_13 = sqrt((POINTS(i,1)-POINTS(i+2+B_PTS,1))^2 + (POINTS(i,2)-POINTS(i+2+B_PTS,2))^2 );
            length_23 = sqrt((POINTS(i+1+A_PTS,1)-POINTS(i+2+B_PTS,1))^2 + (POINTS(i+1+A_PTS,2)-POINTS(i+2+B_PTS,2))^2 );
            
            % finding the circumradius of the traingle with sides length_12, length_13, and length_23
            % which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
            radius2= (length_12*length_13*length_23) / sqrt ((length_12+length_13+length_23)*(length_13+length_23-length_12)...
                *(length_23+length_12-length_13)*(length_12+length_13-length_23));
            if (radius2 <= RADIUS2)
                out=1;
                break;
            end
        end
    end    
end
end