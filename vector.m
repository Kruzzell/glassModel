classdef vector
    properties
        x
        y
        xPrev
        yPrev
        orientation
        velocityX
        velocityY
    end
    methods
        function obj = vector(X,Y,XPrev,YPrev,VelocityX,VelocityY,Orientation)
           % put in some input validation
            obj.x=X;
            obj.y=Y;
            obj.xPrev=XPrev;
            obj.yPrev=YPrev;
            obj.orientation = Orientation;
            obj.velocityX=VelocityX;
            obj.velocityY=VelocityY;
        end
   end 
end