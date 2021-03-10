%% LIC 5 
%Return TRUE if there exists at least one set of two consecutive data points
%where X[j] - X[i] < 0 (where i=j-1)
function out = lic5(POINTS, NUMPOINTS)
out=0;
for i=1:(NUMPOINTS - 1)
    if(POINTS(i,1)>POINTS(i+1,1))
        out=1;
        break;
    end
end

end
