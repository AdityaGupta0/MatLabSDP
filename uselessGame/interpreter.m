classdef interpreter < handle %class for running the program and executing the blocks while checking them simultaniously 
    properties 
        editorWindowArray;
        levelArray;
        BGArray;
        stackPointer; %we abouta go full nand2tetris with this one
        screen;
        level;
        autoGrader;
        stopExecution;
        %ARG=[3,4];
        %THIS=[5,4];
        %THAT=[7,4];
        %LCL=[9,4];
    end
    properties (Constant) %helpful conversion hash maps
        toNumber=containers.Map(cat(2,[56:-1:32],[6:1:31]),[-25:1:25]);
        toSprite=containers.Map([-25:1:25],cat(2,[56:-1:32],[6:1:31]));
    end
    methods 
        function obj = interpreter(screen,level,BGArray,levelArray,editorWindowArray) %constructor
            obj.screen = screen;
            obj.stackPointer = 2;
            obj.BGArray = BGArray;
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.level = level;
            obj.stopExecution = false;
        end
        function updateArrays(obj,BGArray,levelArray,editorWindowArray) %updates the arrays instead of rebuilding entire object
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.BGArray = BGArray;
        end
        function run(obj)
            displayMsg('running...')
            obj.autoGrader = evaluator(obj.level,obj.levelArray); %instantiates an evaluator object
            obj.stackPointer = 2;
            status = 0;
            obj.stopExecution = false;
            steps = -1; %offset by -1 because the blank space is counted as a line
            set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event)); %interupt function
            while obj.stackPointer < 16 && status==0 && ~obj.stopExecution %value is 16 because the stackpointer is incremented after the last line is executed
                fprintf('stackPointer: %d\n',obj.stackPointer);
                obj.levelArray(obj.stackPointer,11) = 110; %draws line pointer
                drawScene(obj.screen,obj.BGArray,obj.levelArray,obj.editorWindowArray); 
                status=executeLine(obj,(obj.editorWindowArray(obj.stackPointer,9))); 
                set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event)); %interupt function
                pause(0.8); 
                obj.stackPointer = obj.stackPointer + 1; 
                obj.levelArray(obj.stackPointer-1,11) = 101; %advances the line pointer
                steps = steps + 1; %increcements the step counter
                drawnow; %checks callback
            end
            if status == 1 %if program stops for non-erroneous reasons check if the level is complete
                obj.autoGrader.finalEval(obj.editorWindowArray,steps);
            end
            set(obj.screen.my_figure, 'WindowButtonDownFcn', ''); %clears the mouse click callback
            function mouseClickCallback(~,~) 
                clickPoint = get(obj.screen.my_figure.CurrentAxes, 'CurrentPoint');
                x = clickPoint(1,1);
                y = clickPoint(1,2);
                disp(x)
                disp(y)
                %Defines the region where clicking stops execution
                if x >= (9*512) && x <=(10*512) && y >= 0 && y <= 512 %pause button
                    obj.stopExecution = true;
                    fprintf('Execution stopped');
                    displayMsg('Program stopped');
                    drawnow;
                end
            end
        end
        function statusCode = executeLine(obj,blockID)
            statusCode = 0; %zero means continue execution, 1 means stop, -1 means errornous stop
            switch blockID
                case 57 %inbox
                    if isInboxEmpty(obj) %if inbox is empty
                        fprintf('cant inbox nothing\n');
                        statusCode = 1;
                    else
                        popInbox(obj);
                    end
                case 58 %outbox
                    if (obj.levelArray(9,4)) == 101 %if LCL is empty
                        fprintf('Cant outbox nothing\n');
                        displayMsg('Error: cant outbox nothing');
                        statusCode = -1;
                    else
                        pushOutbox(obj);
                        statusCode=obj.autoGrader.evalutate(obj.levelArray); %checks the outbox value, if it is incorrect, terminate program
                    end
                case 59 %add
                    statusCode = add(obj); %if add fails, terminate program
                case 60 %sub
                    statusCode = subtract(obj); %if sub fails, terminate program
                case 61 %copyfrom
                    statusCode = copyFrom(obj); %if copyfrom fails, terminate program
                case 62 %copyto
                    if obj.levelArray(9,4) == 101 %if LCL is empty
                        fprintf('cant copy nothing\n');
                        displayMsg('Error: cant copy nothing');
                        statusCode = -1;
                    else
                        copyTo(obj);
                    end
                case 63 %jump if zero
                    statusCode=jumpConditional(obj,0);
                case 64 %jump if negative
                    statusCode=jumpConditional(obj,-1);
                case 65 %jump
                    jump(obj);
                case 102 %bump-
                    statusCode=bump(obj,-1);
                case 103 %bump+
                    statusCode=bump(obj,1);
                case 101 %no block
                    fprintf('no block\n');
                    statusCode=1; %if no block is present, terminate program
            end
        end
        function popInbox(obj) %pops the value in the inbox to LCL
            repeat=true;
            i=3;
            while repeat %finds the first non-empty inbox slot
                if obj.levelArray(i,2) ~= 101
                    obj.levelArray(9,4) = obj.levelArray(i,2);
                    obj.levelArray(i,2) = 101;
                    repeat = false;
                end
                if (i<10)
                    i = i + 1;
                else
                    fprintf('inbox is empty\n');
                    repeat = false;
                end
            end 
        end
        function pushOutbox(obj) %pushes the value in LCL to the outbox. Allows overwriting of outbox
            for i=8:-1:3
                obj.levelArray(i+1,6) = obj.levelArray(i,6); %shifts all values in outbox down
            end
            obj.levelArray(3,6) = obj.levelArray(9,4);
            obj.levelArray(9,4) = 101;
        end
        function boolean = isInboxEmpty(obj) 
            counter=0;
            for i=3:9
                if obj.levelArray(i,2) == 101
                    counter = counter + 1;
                end
            end
            if counter ==7 %if all inbox slots are empty
                boolean=true;
            else
                boolean=false;
            end
        end
        function jump(obj) %jumps to the user designated line
            dest = obj.editorWindowArray(obj.stackPointer,10); %gets destination from levelArray
            fprintf('jumping to %d\n',dest);
            dest = obj.toNumber(dest);
            obj.levelArray(obj.stackPointer,11) = 101; %makes sure the pointer does not linger on the jump block
            obj.stackPointer = dest; %sets stackpointer to the jump desitnation no need to worry about the +1 since the runner handles that 
        end
        function statusCode = jumpConditional(obj,condition) %checks the condition and calls jump func if it is met
            fprintf('possibly jumping \n');
            if obj.levelArray(3,4) == 101 %if ARG is empty terminate program
                fprintf('cant jump-if when ARG is empty\n');
                displayMsg('Error: cant jump-if when ARG is empty');
                statusCode=-1; %terminate program
            else
                statusCode=0;
                switch condition
                    case 0 %jump if zero
                        if obj.toNumber(obj.levelArray(3,4))==0
                            jump(obj);
                        end
                    case -1 %jump if negative
                        if obj.toNumber(obj.levelArray(3,4))<0
                            jump(obj);
                        end
                end
            end
        end
        function copyTo(obj) %copies the value in LCL to the register
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1;
            obj.levelArray(addr,4) = obj.levelArray(9,4);
        end
        function statusCode = copyFrom(obj) %copies the value in the register to LCL
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1;
            if obj.levelArray(addr,4) == 101
                fprintf('cant copy nothing from register\n');
                displayMsg('Error: cant copy nothing from register');
                statusCode = -1;
            else
                obj.levelArray(9,4) = obj.levelArray(addr,4);
                statusCode = 0;
            end
        end
        function statusCode = add(obj) %adds the value in the register to LCL
            statusCode = -1;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant add nothing from register\n');
                displayMsg('Error: cant add nothing from register');
            elseif obj.levelArray(9,4) == 101 %checks if LCL is empty
                fprintf('cant add register from nothing\n');
                displayMsg('Error: cant add if LCL is empty');
            else 
                added = obj.toNumber(obj.levelArray(addr,4)) +obj.toNumber(obj.levelArray(9,4));
                if added > 25 || added < -25 %checks to make sure the value is within the bounds of the sprite sheet
                    fprintf('addition overflow\n');
                    displayMsg('Error: addition overflow');
                else
                    obj.levelArray(9,4) = obj.toSprite(added);
                    statusCode = 0;
                end
            end
        end
        function statusCode = subtract(obj) %subtracts the value in the register from LCL
            statusCode = -1;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101 %checks if the register is empty
                fprintf('cant subtract nothing from register\n');
                displayMsg('Error: cant subtract if register is empty'); %display error message
            elseif obj.levelArray(9,4) == 101 %checks if LCL is empty
                fprintf('cant subtract register from nothing\n');
                displayMsg('Error: cant subtract if LCL is empty');
            else %if both registers are not empty
                subbed =  obj.toNumber(obj.levelArray(9,4)) - obj.toNumber(obj.levelArray(addr,4));
                if subbed > 25 || subbed < -25 
                    fprintf('subtraction overflow\n');
                    displayMsg('Error: subtraction overflow');
                else
                    obj.levelArray(9,4) = obj.toSprite(subbed);
                    statusCode = 0;
                end
            end
        end
        function statusCode = bump(obj,dir) %dir is 1 for bump+ and -1 for bump-
            statusCode = -1; %if bump fails, terminate program
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant bump nothing from register\n');
                displayMsg('Error: cant bump nothing from register');
            else
                bumped = obj.toNumber(obj.levelArray(addr,4)) + dir;
                if bumped > 25 || bumped < -25 %validates output is not out of bounds
                    fprintf('bump overflow\n');
                    displayMsg('Error: bump overflow');
                else %if bump is valid, updated register and LCL
                    obj.levelArray(addr,4) = obj.toSprite(bumped);
                    obj.levelArray(9,4) = obj.toSprite(bumped);
                    statusCode = 0;
                end
            end
        end
    end
    methods (Static) %helpful conversion functions
        function spriteID = number2Sprite(num)
            toSprite=containers.Map([-25:1:25],cat(2,[56:-1:32],[6:1:31]));
            spriteID = toSprite(num);
        end
        function num = sprite2Number(spriteID)
            toNumber=containers.Map(cat(2,[56:-1:32],[6:1:31]),[-25:1:25]);
            num = toNumber(spriteID);
        end
    end
end