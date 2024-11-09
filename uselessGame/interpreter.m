classdef interpreter < handle
    properties 
        editorWindowArray;
        levelArray;
        BGArray;
        stackPointer; %we abouta go full nand2tetris with this one
        intArray;
        screen;
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
            obj.intArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,-1,-2,-3,-4,];
        end
        function updateEditorWindowArray(obj,editorWindowArray)
            obj.editorWindowArray = editorWindowArray;
        end
        function updateLevelArray(obj,levelArray)
            obj.levelArray = levelArray;
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
                    popInbox(obj);
                case 58 %outbox
                    if (obj.levelArray(9,4)) == 101 %if LCL is empty
                        fprintf('Cant outbox nothing\n');
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
            if obj.levelArray(2,6) ~= 101
                boolean=true;
            else
                boolean=false;
            end
        end
        function boolean = isInboxEmpty(obj)
            if obj.levelArray(9,2) == 101
                boolean=true;
            else
                boolean=false;
            end
        end
    end
end