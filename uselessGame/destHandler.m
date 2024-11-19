classdef destHandler < handle %class for handling the destination/register assignment of jump and manipluation blocks
    properties 
        screen;
        BGArray;
        FGArray;
        OVArray;
    end
    methods
        function obj = destHandler(screen,bgarray,fgarray,ovarray)
            obj.screen = screen;
            obj.BGArray = bgarray;
            obj.FGArray = fgarray;
            obj.OVArray = ovarray;
        end
        function lineNumber = getJumpDest(obj)
            %obj.BGArray(1,4) = 92;
            %obj.BGArray(1,5) = 93;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %draws the scene with the input prompt
            displayMsg('Enter a line Number. (Enter Preeceeding zero for single digits)') %sets the title to the input prompt
            lineNum1 = str2double(getKeyboardInput(obj.screen));%gets the keyboard input from user and converts it to an integer
            lineNum2 = str2double(getKeyboardInput(obj.screen)); 
            lineNum = lineNum1*10+lineNum2;
            if lineNum<1 || lineNum>14 || isnan(lineNum) %validates that the line number is within the bounds of the lines
                lineNum = 1;
            end
            fprintf('Line Number: %d\n',lineNum);
            %obj.BGArray(1,4) = 1;
            %obj.BGArray(1,5) = 1;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %redraws the scene without the input prompt
            title('') %clears the title
            lineNumber = lineNum; %returns the line number 
        end
        function registerNumber = getRegisterDest(obj)
            %obj.BGArray(1,4) = 90;
            %obj.BGArray(1,5) = 91;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %draws the scene with the input prompt
            displayMsg('Enter Register Destination (1=ARG 2=THIS 3=THAT)') %sets the title to the input prompt
            registerNum = str2double(getKeyboardInput(obj.screen)); 
            if registerNum<1 || registerNum>3 || isnan(registerNum)%validates that the register number is within the bounds of the registers
                registerNum = 1;
            end
            registerNum = -registerNum; %negates the register number to indicate that it is a register
            fprintf('Register Number: %d\n',registerNum);
            %obj.BGArray(1,4) = 1;
            %obj.BGArray(1,5) = 1;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %redraws the scene without the input prompt
            title('') %clears the title
            registerNumber = registerNum; %returns the register number
        end
    end
end