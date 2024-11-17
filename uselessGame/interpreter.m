classdef interpreter < handle
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
    properties (Constant)
        toNumber=containers.Map(cat(2,[56:-1:32],[6:1:31]),[-25:1:25]);
        toSprite=containers.Map([-25:1:25],cat(2,[56:-1:32],[6:1:31]));
    end
    methods 
        function obj = interpreter(screen,level,BGArray,levelArray,editorWindowArray)
            obj.screen = screen;
            obj.stackPointer = 2;
            obj.BGArray = BGArray;
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.level = level;
            obj.stopExecution = false;
        end
        function updateArrays(obj,BGArray,levelArray,editorWindowArray)
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.BGArray = BGArray;
        end
        function run(obj)
            displayMsg('running...')
            obj.autoGrader = evaluator(obj.level,obj.levelArray);
            obj.stackPointer = 2;
            status = 0;
            obj.stopExecution = false;
            set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event));

            while obj.stackPointer < 14 && status==0 && ~obj.stopExecution
                obj.levelArray(obj.stackPointer,11) = 110;
                status=executeLine(obj,(obj.editorWindowArray(obj.stackPointer,9)));
                drawScene(obj.screen,obj.BGArray,obj.levelArray,obj.editorWindowArray);
                set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event));
                pause(0.8);
                obj.stackPointer = obj.stackPointer + 1;
                obj.levelArray(obj.stackPointer-1,11) = 101;
                fprintf('stackPointer: %d\n',obj.stackPointer);
                drawnow;
            end
            if status == 1
                obj.autoGrader.finalEval();
            end
            set(obj.screen.my_figure, 'WindowButtonDownFcn', ''); %clears the mouse click callback
            function mouseClickCallback(~,~)
                clickPoint = get(obj.screen.my_figure.CurrentAxes, 'CurrentPoint');
                x = clickPoint(1,1);
                y = clickPoint(1,2);
                disp(x)
                disp(y)
                % Define the region where clicking stops execution
                if x >= (9*512) && x <=(10*512) && y >= 0 && y <= 512
                    obj.stopExecution = true;
                    disp('Execution stopped');
                    displayMsg('Program stopped');
                    drawnow;
                end
            end
        end
        function statusCode = executeLine(obj,blockID)
            statusCode = 0; %zero means continue execution, 1 means stop, -1 means error
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
                    statusCode=1;
            end
        end
        function popInbox(obj) 
            repeat=true;
            i=3;
            while repeat
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
                obj.levelArray(i+1,6) = obj.levelArray(i,6);
            end
            obj.levelArray(3,6) = obj.levelArray(9,4);
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
        function jump(obj) %jumps to the user defined line
            dest = obj.editorWindowArray(obj.stackPointer,10); %gets destination from levelArray
            fprintf('jumping to %d\n',dest);
            dest = obj.toNumber(dest);
            %obj.levelArray(obj.stackPointer,11) = 101; %makes sure the pointer does not linger on the jump block
            obj.stackPointer = dest; %sets stackpointer to the jump desitnation no need to worry about the +1 since the runner handles that 
        end
        function statusCode = jumpConditional(obj,condition) %checks the condition and calls jump func if it is met
            fprintf('possibly jumping \n');
            if obj.levelArray(3,4) == 101 %if ARG is empty terminate program
                fprintf('cant jump-if when ARG is empty\n');
                displayMsg('Error: cant jump-if when ARG is empty');
                statusCode=-1;
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
        function copyTo(obj) 
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1;
            obj.levelArray(addr,4) = obj.levelArray(9,4);
        end
        function statusCode = copyFrom(obj)
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
        function statusCode = add(obj)
            statusCode = -1;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant add nothing from register\n');
                displayMsg('Error: cant add nothing from register');
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
        function statusCode = subtract(obj)
            statusCode = -1;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant subtract nothing from register\n');
                displayMsg('Error: cant subtract nothing from register');
            else
                subbed = obj.toNumber(obj.levelArray(addr,4)) - obj.toNumber(obj.levelArray(9,4));
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
                else
                    obj.levelArray(addr,4) = obj.toSprite(bumped);
                    obj.levelArray(9,4) = obj.toSprite(bumped);
                    statusCode = 0;
                end
            end
        end
    end
    methods (Static) %these are just conversion helpers
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