% Coding Assignment
% Hossein Abdi

%%
close all
clear all
clc

%% Fixed Parameters
dt = 0.01;      % Time Step
dY_d = 0.01;    % Y component of desired velocity
Kp = 0.5; %1;   % Proportional Gain
Ki = 0.1; %0.5; % Integration Gain
Kd = 1; %2;     % Derivative Gain

%% Get Data
[X_wp,Y_wp,X_0,Y_0,CO,r_o] = GetData();
N_wp = length(X_wp);    % Number of Waypoints
X_d = [X_wp(1):0.01:X_wp(N_wp)];    %X component of desired position
Y_d = interp1(X_wp,Y_wp,X_d);       %Y component of desired position
N_d = length(X_d);                  %Number of desired position
X(1) = X_0;         % X component of Starting Point
Y(1) = Y_0;         % Y component of Starting Point
X_o = X_wp(CO);     % X component of Circular Objects
Y_o = Y_wp(CO);     % Y component of Circular Objects
N_o = length(CO);   % Number of Circular Objects

%% Initialization
SUMx(1) = 0;    % Summation of the X component of error for integration
SUMy(1) = 0;    % Summation of the Y component of error for integration
dY_o = 0;       % dY becouse of objects

%% 
for i=1:N_d
r = sqrt((Y(i)-Y_o).^2+(X_d(i)-X_o).^2);    % Distance from objects
if ~isempty(CO)
dY_o = sign(Y_o-Y(i))*2./abs(10*(r_o-r));   % dY becouse of objects
end
dY = (Ki*SUMy(i)+Kp*(Y_d(i)-Y(i)))/Kd+dY_d-sum(dY_o); % Dynamic of error: Ki*e+Kp*de+Kd*dde=0 (e=Y_d-Y)
Y(i+1) = Y(i)+dY*dt;    % Integration
SUMy(i+1) = SUMy(i)+(Y_d(i)-Y(i))*dt;
end

%% Plot
for i=1:N_o
circle(X_o(i),Y_o(i),r_o(i));   % Plot circular objects
end

hold on
plot(X_wp,Y_wp,'kO')    % Plot Waypoints
plot(X_d,Y_d,'y')       % Plot desired points
plot(X_d,Y(1:N_d),'b')  % Plot the curve
axis equal 
box on