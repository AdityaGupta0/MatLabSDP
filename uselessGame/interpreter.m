classdef interpreter < handle
    properties 
        editorWindowArray;
        levelArray;
        BGArray;
        stackPointer; %we abouta go full nand2tetris with this one
        screen;
        toNumber;
        toSprite;
        %ARG=[3,4];
        %THIS=[5,4];
        %THAT=[7,4];
        %LCL=[9,4];
    end
    methods 
        function obj = interpreter(screen,BGArray,levelArray,editorWindowArray)
            obj.screen = screen;
            obj.stackPointer = 2;
            obj.BGArray = BGArray;
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.toSprite = containers.Map([-25:1:25],cat(2,[32:1:56],[6:1:31]));
            obj.toNumber = containers.Map(cat(2,[32:1:56],[6:1:31]),[-25:1:25])
        end
        function updateArrays(obj,BGArray,levelArray,editorWindowArray)
            obj.editorWindowArray = editorWindowArray;
            obj.levelArray = levelArray;
            obj.BGArray = BGArray;
        end
        function run(obj)
            obj.stackPointer = 2;
            repeat = true;
            while obj.stackPointer < 14 && repeat
                repeat=executeLine(obj,(obj.editorWindowArray(obj.stackPointer,9)));
                drawScene(obj.screen,obj.BGArray,obj.levelArray,obj.editorWindowArray);
                pause(1);
                obj.stackPointer = obj.stackPointer + 1;
                fprintf('stackPointer: %d\n',obj.stackPointer);
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
                    if (obj.levelArray(9,4)) == 101 || isOutboxFull(obj) %if LCL is empty and outbox is full
                        fprintf('Cant outbox nothing or outbox full\n');
                        boolean = false;
                    else
                        pushOutbox(obj);
                    end
                case 59 %add
                case 60 %sub
                case 61 %copyfrom
                case 62 %copyto
                case 63 %jump if zero
                case 64 %jump if negative
                case 65 %jump
                    jump(obj);
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
            repeat=true;
            i=9;
            while repeat
                if obj.levelArray(i,6) == 101
                    obj.levelArray(i,6) = obj.levelArray(9,4);
                    obj.levelArray(9,4) = 101;
                    repeat = false;
                end
                if (i>2)
                    i = i -1;
                else
                    fprintf('outbox is full\n');
                    repeat = false;
                end
            end 
        end
        function boolean = isOutboxFull(obj)
            counter=0;
            for i=2:9
                if obj.levelArray(i,6) ~= 101
                    counter = counter + 1;
                end
            end
            if counter == 7 %if all outbox slots are full
                boolean=true;
            else
                boolean=false;
            end
        end
        function boolean = isInboxEmpty(obj)
            if (obj.levelArray(9,2) == 101) %if inbox is empty
                boolean=true;
            else
                boolean=false;
            end
        end
        function jump(obj)
            dest = obj.editorWindowArray(obj.stackPointer,10); %gets destination from levelArray
            fprintf('jumping to %d\n',dest);
            dest = obj.toNumber(dest);
            obj.stackPointer = dest; %sets stackpointer to the jump desitnation+1 since lines are offset
        end
    end
end