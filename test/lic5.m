%% LIC 5 
%Return TRUE if there exists at least one set of two consecutive data points
%where X[j] - X[i] < 0 (where i=j-1)
function out = lic5(POINTS, NUMPOINTS)
out=0;
for i=1:(NUMPOINTS - 1)
    if(comparison_x(POINTS(i,:),POINTS(i+1,:)))
        out=1;
        break;
    end
end

end
function out = comparison_x (point1,point2)
    out= (point1(1)>point2(1));
end
