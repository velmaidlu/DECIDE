%% LIC 3
%There exists at least one set of three consecutive data points that 
%are the vertices of a triangle with area greater than AREA1

function out = lic3(POINTS, NUMPOINTS, AREA1) 
out=0;
 for i=1:(NUMPOINTS - 2)
     % finding the side length of the triangle
     length_12= sqrt((POINTS(i,1)-POINTS(i+1,1))^2 + (POINTS(i,2)-POINTS(i+1,2))^2 );     
     length_13= sqrt((POINTS(i,1)-POINTS(i+2,1))^2 + (POINTS(i,2)-POINTS(i+2,2))^2 );
     length_23= sqrt((POINTS(i+1,1)-POINTS(i+2,1))^2 + (POINTS(i+1,2)-POINTS(i+2,2))^2 );
     %Heron's Formula for the area of a triangle 
     p= (length_12+length_13+length_23)/2;
     Area= sqrt(p*(p-length_12)*(p-length_13)*(p-length_23));
     if (Area>AREA1)
         out=1;
         break;
     end
 end 

end
