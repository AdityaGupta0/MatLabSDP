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
            obj.autoGrader = evaluator(obj.level,obj.levelArray);
            obj.stackPointer = 2;
            repeat = true;
            obj.stopExecution = false;
            set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event));
            while obj.stackPointer < 14 && repeat && ~obj.stopExecution
                obj.levelArray(obj.stackPointer,11) = 110;
                repeat=executeLine(obj,(obj.editorWindowArray(obj.stackPointer,9)));
                drawScene(obj.screen,obj.BGArray,obj.levelArray,obj.editorWindowArray);
                set(obj.screen.my_figure, 'WindowButtonDownFcn', @(src,event)mouseClickCallback(src,event));
                pause(0.8);
                obj.stackPointer = obj.stackPointer + 1;
                obj.levelArray(obj.stackPointer-1,11) = 101;
                fprintf('stackPointer: %d\n',obj.stackPointer);
                drawnow;
            end
            obj.autoGrader.finalEval();
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
                    drawnow;
                end
            end
        end
        function boolean = executeLine(obj,blockID)
            boolean = true;
            switch blockID
                case 57 %inbox
                    if isInboxEmpty(obj) %if inbox is empty
                        fprintf('cant inbox nothing\n');
                        boolean = false;
                    else
                        popInbox(obj);
                    end
                case 58 %outbox
                    if (obj.levelArray(9,4)) == 101 %if LCL is empty and
                        fprintf('Cant outbox nothing\n');
                        boolean = false;
                    else
                        pushOutbox(obj);
                        boolean=obj.autoGrader.evalutate(obj.levelArray); %checks the outbox value, if it is incorrect, terminate program
                    end
                case 59 %add
                    boolean = add(obj); %if add fails, terminate program
                case 60 %sub
                case 61 %copyfrom
                    boolean = copyFrom(obj); %if copyfrom fails, terminate program
                case 62 %copyto
                    if obj.levelArray(9,4) == 101 %if LCL is empty
                        fprintf('cant copy nothing\n');
                        boolean = false;
                    else
                        copyTo(obj);
                    end
                case 63 %jump if zero
                    boolean=jumpConditional(obj,0);
                case 64 %jump if negative
                    boolean=jumpConditional(obj,-1);
                case 65 %jump
                    jump(obj);
                case 102 %bump-
                    boolean=bump(obj,-1);
                case 103 %bump+
                    boolean=bump(obj,1);
                case 101 %no block
                    fprintf('no block\n');
                    boolean=false;    
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
        function pushOutbox(obj)
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
        function jump(obj)
            dest = obj.editorWindowArray(obj.stackPointer,10); %gets destination from levelArray
            fprintf('jumping to %d\n',dest);
            dest = obj.toNumber(dest);
            %obj.levelArray(obj.stackPointer,11) = 101; %makes sure the pointer does not linger on the jump block
            obj.stackPointer = dest; %sets stackpointer to the jump desitnation no need to worry about the +1 since the runner handles that 
        end
        function boolean = jumpConditional(obj,condition)
            boolean=false;
            fprintf('possibly jumping \n');
            if obj.levelArray(3,4) == 101 %if ARG is empty terminate program
                fprintf('cant jump-if when ARG is empty\n');
            else
                boolean=true;
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
        function boolean = copyFrom(obj)
            boolean = false;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1;
            if obj.levelArray(addr,4) == 101
                fprintf('cant copy nothing from register\n');
            else
                obj.levelArray(9,4) = obj.levelArray(addr,4);
                boolean = true;
            end
        end
        function boolean = add(obj)
            boolean = false;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant add nothing from register\n');
            else
                added = obj.toNumber(obj.levelArray(addr,4)) +obj.toNumber(obj.levelArray(9,4));
                if added > 25 || added < -25 
                    fprintf('addition overflow\n');
                else
                    obj.levelArray(9,4) = obj.toSprite(added);
                    boolean = true;
                end
            end
        end
        function boolean = subtract(obj)
            boolean = false;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant subtract nothing from register\n');
            else
                subbed = obj.toNumber(obj.levelArray(addr,4)) - obj.toNumber(obj.levelArray(9,4));
                if subbed > 25 || subbed < -25 
                    fprintf('subtraction overflow\n');
                else
                    obj.levelArray(9,4) = obj.toSprite(subbed);
                    boolean = true;
                end
            end
        end
        function boolean = bump(obj,dir) %dir is 1 for bump+ and -1 for bump-
            boolean = false;
            addr = (obj.editorWindowArray(obj.stackPointer,10)*2)-1; %converts adress to line number of spirte
            if obj.levelArray(addr,4) == 101
                fprintf('cant bump nothing from register\n');
            else
                bumped = obj.toNumber(obj.levelArray(addr,4)) + dir;
                if bumped > 25 || bumped < -25 
                    fprintf('bump overflow\n');
                else
                    obj.levelArray(addr,4) = obj.toSprite(bumped);
                    obj.levelArray(9,4) = obj.toSprite(bumped);
                    boolean = true;
                end
            end
        end
    end
    methods (Static)
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