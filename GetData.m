function [X_wp,Y_wp,X,Y,CO,r_o] = GetData()

X_wp = input('Enter the matrix of X of the waypoints (including objects): ');
Y_wp = input('Enter the matrix of Y of the waypoints (including objects): ');
X(1) = X_wp(1);
Q_sp = input('Is the first waypoint your starting point? Y/N: ','s');
if Q_sp == 'N'
    Y(1) = input('Enter the Y of the Starting Point: ');
elseif Q_sp == 'Y'
    Y(1) = Y_wp(1);
end
display(['You have ' num2str(length(X_wp).') ' waypoints as following:'])    
for j=1:length(X_wp)
    display([num2str(j.') '. (' num2str(X_wp(j).') ',' num2str(Y_wp(j).') ')'])
end
CO = input('Enter the matrix of number of waypoints that you want to consider as the circular objects: ');
r_o = input('Enter the matrix of radius of circular objects: ');
end
