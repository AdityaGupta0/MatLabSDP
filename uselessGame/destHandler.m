classdef destHandler < handle %class for handling the destination/register assignment of jump and manipluation blocks
    properties 
        screen;
        BGArray;
        FGArray;
        OVArray;
    end
    methods
        function obj = destHandler(screen,bgarray,fgarray,ovarray) %constructor
            obj.screen = screen;
            obj.BGArray = bgarray;
            obj.FGArray = fgarray;
            obj.OVArray = ovarray;
        end
        function lineNumber = getJumpDest(obj) %gets the line number for the jump block
            displayMsg('Enter a line Number. (Enter Preeceeding zero for single digits)') %sets the title to the input prompt
            lineNum1 = str2double(getKeyboardInput(obj.screen));%gets the keyboard input from user and converts it to an integer
            lineNum2 = str2double(getKeyboardInput(obj.screen)); 
            lineNum = lineNum1*10+lineNum2;
            if lineNum<1 || lineNum>14 || isnan(lineNum) %validates that the line number is within the bounds of the lines
                lineNum = 1; %defaults to line 1 if the input is invalid
            end
            fprintf('Line Number: %d\n',lineNum);
            title('') %clears the title
            lineNumber = lineNum; %returns the line number 
        end
        function registerNumber = getRegisterDest(obj) %gets the register number for the manipulation blocks
            displayMsg('Enter Register Destination (1=ARG 2=THIS 3=THAT)') %sets the title to the input prompt
            registerNum = str2double(getKeyboardInput(obj.screen)); 
            if registerNum<1 || registerNum>3 || isnan(registerNum)%validates that the register number is within the bounds of the registers
                registerNum = 1; %sets the register number to ARG if the input is invalid
            end
            registerNum = -registerNum; %negates the register number to indicate that it is a register
            fprintf('Register Number: %d\n',registerNum);
            title('') %clears the title
            registerNumber = registerNum; %returns the register number
        end
    end
end