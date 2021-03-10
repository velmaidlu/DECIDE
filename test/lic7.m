%% LIC 7
%There exists at least one set of two data points separated by 
%exactly K_PTS consecutive intervening points that are a distance 
%greater than the length, LENGTH1, apart. when NUMPOINTS >= 3.
function out= lic7(POINTS,NUMPOINTS,K_PTS,LENGTH1)
out=0;
if (NUMPOINTS>=3)
    for i=1:(NUMPOINTS-1-K_PTS)
        distance = sqrt((POINTS(i,1)-POINTS(i+1+K_PTS,1))^2+(POINTS(i,2)-POINTS(i+1+K_PTS,2))^2);
        if(distance > LENGTH1)
            out=1;
            break;
        end
    end
end
end 