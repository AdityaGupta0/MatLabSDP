classdef jumpHandler < handle
    properties 
        lineNum;
    end
    methods
        function obj = jumpHandler(screen,bgarray,fgarray,ovarray)
            bgarray(12,6) = 92;
            bgarray(12,7) = 93;
            drawScene(screen,bgarray,fgarray,ovarray); %draws the scene with the input prompt

            lineNum1 = str2double(getKeyboardInput(screen)); %poopypants
            lineNum2 = str2double(getKeyboardInput(screen)); 
            obj.lineNum = lineNum1*10+lineNum2;
            if obj.lineNum<0 || obj.lineNum>15 %validates that the line number is within the bounds of the lines
                obj.lineNum = 1;
            end
            bgarray(12,6) = 1;
            bgarray(12,7) = 1;
            drawScene(screen,bgarray,fgarray,ovarray); %redraws the scene without the input prompt
        end
        function lineNumber = getLineNum(obj)
            lineNumber = obj.lineNum; %returns the line number retreived from the constructor
        end
    end
end