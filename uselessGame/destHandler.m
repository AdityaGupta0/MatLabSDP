classdef destHandler < handle
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
            obj.BGArray(1,4) = 92;
            obj.BGArray(1,5) = 93;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %draws the scene with the input prompt
            displayMsg('Enter a line Number. (Enter Preeceeding zero for single digits)','HorizontalAlignment','left') %sets the title to the input prompt
            lineNum1 = str2double(getKeyboardInput(obj.screen));%gets the keyboard input from user and converts it to an integer
            lineNum2 = str2double(getKeyboardInput(obj.screen)); 
            lineNum = lineNum1*10+lineNum2;
            if lineNum<1 || lineNum>15 %validates that the line number is within the bounds of the lines
                lineNum = 1;
            end
            obj.BGArray(1,4) = 1;
            obj.BGArray(1,5) = 1;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %redraws the scene without the input prompt
            title('') %clears the title
            lineNumber = lineNum; %returns the line number 
        end
        function registerNumber = getRegisterDest(obj)
            obj.BGArray(1,4) = 90;
            obj.BGArray(1,5) = 91;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %draws the scene with the input prompt
            displayMsg('Enter Register Destination (1=ARG 2=THIS 3=THAT)') %sets the title to the input prompt
            registerNum = str2double(getKeyboardInput(obj.screen)); 
            if registerNum<1 || registerNum>4 %validates that the register number is within the bounds of the registers
                registerNum = 1;
            end
            registerNum = -registerNum; %negates the register number to indicate that it is a register
            obj.BGArray(1,4) = 1;
            obj.BGArray(1,5) = 1;
            %drawScene(obj.screen,obj.BGArray,obj.FGArray,obj.OVArray); %redraws the scene without the input prompt
            title('') %clears the title
            registerNumber = registerNum; %returns the register number
        end
    end
end