classdef jumpHandler < handle
    properties 
        lineNum;
    end
    methods
        function obj = jumpHandler(screen,bgarray,fgarray,ovarray)
            bgarray(12,6) = 92;
            bgarray(12,7) = 93;
            drawScene(screen,bgarray,fgarray,ovarray);
            lineNum1 = str2double(getKeyboardInput(screen))
            lineNum2 = str2double(getKeyboardInput(screen)) %this is rediculus but i have to this apparantly fucking hell man
            obj.lineNum = lineNum1*10+lineNum2
            if obj.lineNum<0 || obj.lineNum>15 %validates that the line number is within the bounds of the lines
                obj.lineNum = 1;
            end
            bgarray(12,6) = 1;
            bgarray(12,7) = 1;
            drawScene(screen,bgarray,fgarray,ovarray);
        end
        function lineNumber = getLineNum(obj)
            lineNumber = obj.lineNum;
        end
    end
end