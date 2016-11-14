
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
    y = rand * boxSide;
    % random distribution of velocities up to vMax
    velocityX = rand * vMax;
    velocityY = rand * vMax;
    % random orientiation between 0 and 2pi
    orientation = rand * 2 * pi;
    
    molecule(i) = vector(x,y,velocityX,velocityY,orientation);

end
% array to store (x,y) for each molecule
moleculeArray = zeros(particleNo,2);

for i=1:timeNo
    % calculate pos and vel at the next time step
   nextTimeStep(molecule,boxSide, particleDiameter, timeStep);
   for j=1:particleNo
       % fill array of positions
      moleculeArray(j,1) = molecule(j).x;
      moleculeArray(j,2) = molecule(j).y;
   end
   % plot a graph of the time step
scatter( moleculeArray(:,1) , moleculeArray(:,2));
end
