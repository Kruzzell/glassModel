function nextTimeStep(prev, pSize, bSize, dt);

particleNo = length(prev);

dx = 0.1; % in nm
dy = dx;

separation = zeros(particleNo);
separationDX = zeros(particleNo);
separationDY = zeros(particleNo);
forceX = zeros(particleNo,1);
forceY = zeros(particleNo,1);

%%%%%%%%%%%%%    SEPARATION   %%%%%%%%%%%%%

for i=1:1:particleNo %% number of particles
    
    for j=1:1:(particleNo) %% number of particles minus 1 (forces on each particle)       
        if i==j
        else
        %% Separation %%
        separation(i,j) = sqrt( (prev(i).x-prev(j).x)^2 + (prev(i).y-prev(j).y)^2 );
        
        %% Separation x+dx %%
        separationDX(i,j) = sqrt( (prev(i).x+dx-prev(j).x)^2 + (prev(i).y-prev(j).y)^2 );

        %% Separation y+dy %%
        separationDY(i,j) = sqrt( (prev(i).x-prev(j).x)^2 + (prev(i).y+dy-prev(j).y)^2 );
        end 
    end
    
end 

%%%%%%%%%%%%%   ACCELERATION  %%%%%%%%%%%%%

for i=1:1:particleNo %% For each particle calculate potential %%
    for j=1:1:(particleNo-1) %% Potential from each other particle %%
        forceX(i) = forceX(i) + ( ( (exp(separationDX(i,j)/pSize)/(separationDX(i,j)/pSize))... 
                            - (exp(separation(i,j)/pSize)/(separation(i,j)/pSize)) )/dx );
                        
        forceY(i) = forceY(i) + ( ( (exp(separationDY(i,j)/pSize)/(separationDY(i,j)/pSize))... 
                            - (exp(separation(i,j)/pSize)/(separation(i,j)/pSize)) )/dy );
        
    end 
    
end 


%%%%%%%%%%%%%    VELOCITY     %%%%%%%%%%%%%
for i=1:1:particleNo
    %% v = u + at %%
    nextTimeStep(i).velocityX = prev(i).velocityX + forceX(i)*dt;
    nextTimeStep(i).velocityY = prev(i).velocityY + forceY(i)*dt;

end 


%%%%%%%%%%%%%    POSITION     %%%%%%%%%%%%%
for i=1:1:particleNo 
    %% s = s0 + vdt + 1/2 a dt^2 %%
    nextTimeStep(i).x = prev(i).x + nextTimeStep(i).velocityX*dt + 0.5*forceX(i)*dt^2;
    nextTimeStep(i).y = prev(i).y + nextTimeStep(i).velocityY*dt + 0.5*forceY(i)*dt^2;
    
        %% check that the position is in the box %%
            % left side
            if nextTimeStep(i).x - (pSize/2) < 0
                nextTimeStep(i).x = - nextTimeStep(i).x;
                nextTimeStep(i).velocityX = - nextTimeStep(i).velocityX(i);
            end 
            % top
            if nextTimeStep(i).y - (pSize/2) > bSize
                nextTimeStep(i).y = (2*bSize) - nextTimeStep(i).y;
                nextTimeStep(i).velocityY = - nextTimeStep(i).velocityY;
            end
            % right side
            if nextTimeStep(i).x + (pSize/2) > bSize
                nextTimeStep(i).x = (2*bSize) - nextTimeStep(i).x;
                nextTimeStep(i).velocityX = - nextTimeStep(i).velocityX;                
            end 
            % bottom
            if nextTimeStep(i).y - (pSize/2) < 0
                nextTimeStep(i).y = - nextTimeStep(i).y;
                nextTimeStep(i).velocityY = - nextTimeStep(i).velocityY(i);
            end
            
            % orientation for now stays the same 
            nextTimeStep(i).orientation = prev(i).orientation;

end



nextTimeStep = 0;

end
