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
        point1= POINTS(i,:);
        point2=POINTS(i+1+A_PTS,:);
        point3= POINTS(i+2+A_PTS+B_PTS,:);
        length_12 = norm(point1-point2);
        length_13 = norm(point1-point3);
        length_23 = norm(point2-point3);
        radius1= circumradius_finder (length_12,length_13,length_23);
        if (radius1 > RADIUS1)
                out1=1;
                break;
        end
    end
    if ( out1 == 1)
        for i=1 :(NUMPOINTS-2-A_PTS-B_PTS) %% checking second condition
            point1= POINTS(i,:);
            point2=POINTS(i+1+A_PTS,:);
            point3= POINTS(i+2+A_PTS+B_PTS,:);
            length_12 = norm(point1-point2);
            length_13 = norm(point1-point3);
            length_23 = norm(point2-point3);
            radius2= circumradius_finder (length_12,length_13,length_23);
            if (radius2 <= RADIUS2)
                out=1;
                break;
            end
        end
    end    
end
end

function radius = circumradius_finder(length1,length2,length3)% finding the circumradius of the traingle with sides length_12, length_13, and length_23                                                              %which is (for a,b,c) radius=(abc) / sqrt((a + b + c)(b + c - a)(c + a - b)(a + b - c))
radius= (length1*length2*length3) / sqrt ((length1+length2+length3)*(length2+length3-length1)...
    *(length3+length1-length2)*(length1+length2-length3));
end
