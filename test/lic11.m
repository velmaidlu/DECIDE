%% LIC 11
%There exists at least one set of two data points, (X[i],Y[i]) and (X[j],Y[j]), separated by
%exactly G_PTS consecutive intervening points, such that X[j] - X[i] < 0. (where i < j ) 
%NUMPOINTS < 3
function out = lic11(POINTS,NUMPOINTS,G_PTS)
out=0;
if (NUMPOINTS>=3)
    for i= 1: (NUMPOINTS-1-G_PTS)
        if ( POINTS(i,1)> POINTS(i+1+G_PTS,1) )
            out=1;
        end
    end
    
end
end