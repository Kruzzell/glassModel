
%%% ----- USER INPUTS -----------------------------------------------------

boxSide = 4; %nm
particleDiameter = 6E-1; %nm
vMax = 1; %nm/s
particleNo = 10;

timeStep = 0.1; %s
endTime = 1; %s

%%% -----------------------------------------------------------------------

timeNo = endTime/timeStep;

%molecule = zeros(particleNo,timeNo);
% for i=1:timeNo
%     for j=1:particleNo
%         molecule(j,i)=vector;
%     end
% end

% initialisation of variables
for i=1:1:particleNo
    % random distribution of coordinates across box
    x = rand * boxSide;
    xPrev = rand * boxSide;
    y = rand * boxSide;
    yPrev = rand * boxSide;
    % random distribution of velocities up to vMax
    velocityX = rand * vMax;
    velocityY = rand * vMax;
    % random orientiation between 0 and 2pi
    orientation = rand * 2 * pi;
    
    molecule = vector(x,y,xPrev,yPrev,velocityX,velocityY,orientation);
    moleculeArray(i,1) = molecule;
end

for k = 1:timeStep:endTime
   molecule(:,k) = nextTimeStep(molecule(:,k-1),particleSize,boxSide,timeStep);
end

