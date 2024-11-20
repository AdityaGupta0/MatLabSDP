classdef levelScreen < handle %class for the level screen and the editor window and maps all user inputs to the correct functions
    properties
        level;
        screen;
        levelScreenBGArray;
        levelScreenArray
        editorWindowArray;
        linePointer;
        interpret;
        runned;
    end
    methods
        function obj = levelScreen(level,screen) %constructor
            obj.level = level;
            obj.screen = screen;
            obj.linePointer = 1;
            obj.levelScreenArray = arrayMaker.getLevelScreenArray(level);
            obj.levelScreenBGArray = arrayMaker.getBGArray();
            obj.editorWindowArray = arrayMaker.getEditorWindowArray();
            obj.interpret = interpreter(obj.screen,obj.level,obj.levelScreenBGArray,obj.levelScreenArray,obj.editorWindowArray);
            obj.runned = false;
        end
        %getter and setter methods
        function array = getLevelScreenBGArray(obj)
            array = obj.levelScreenBGArray;
        end
        function array = getLevelScreenArray(obj)
            array = obj.levelScreenArray;
        end
        function array = getEditorWindowArray(obj)
            array = obj.editorWindowArray;
        end
        function setLevelScreenArray(obj,array)
            obj.levelScreenArray = array;
        end
        function setEditorWindowArray(obj,array)
            obj.editorWindowArray = array;
        end
        function setLevelScreenBGArray(obj,array)
            obj.levelScreenBGArray = array;
        end
        function setNextLine(obj,line)
            obj.linePointer = line;
        end
        function eventNum = getClickEvent(obj,r,c,b) %maps all the level buttons to respective functions
            status = 0;
            if b==1
                blockhandle = blockHandler(obj.levelScreenBGArray,obj.editorWindowArray,obj.linePointer);
                destHandle = destHandler(obj.screen,obj.levelScreenBGArray,obj.levelScreenArray,obj.editorWindowArray);
                if (r>11) && (c<7) %if mouse is clicked in the block select window
                    status =1;
                    if (r==12) && (c==2) %inbox
                        fprintf('inbox\n')
                        addBlock(blockhandle,'inbox');
                    elseif (r==12) && (c==4) %outbox
                        fprintf('outbox\n')
                        addBlock(blockhandle,'outbox');
                    elseif (r==13) && (c==2) %add
                        fprintf('add\n')
                        addBlock(blockhandle,'add',destHandle.getRegisterDest());
                    elseif (r==13) && (c==4) %sub
                        fprintf('sub\n')
                        addBlock(blockhandle,'sub',destHandle.getRegisterDest());
                    elseif (r==13) && (c==6) %bump down
                        fprintf('bump down\n')
                        addBlock(blockhandle,'bump-',destHandle.getRegisterDest());
                    elseif (r==12) && (c==6) %backspace
                        fprintf('backspace\n')
                        removeBlock(blockhandle);
                    elseif (r==14) && (c==2) %copyfrom
                        fprintf('copyfrom\n')
                        addBlock(blockhandle,'copyfrom',destHandle.getRegisterDest());
                    elseif (r==14) && (c==4) %copyto
                        fprintf('copyto\n')
                        addBlock(blockhandle,'copyto',destHandle.getRegisterDest());
                    elseif (r==14) && (c==6) %bump up
                        fprintf('bump up\n')
                        addBlock(blockhandle,'bump+',destHandle.getRegisterDest());
                    elseif (r==15) && (c==2) %jump if zero
                        fprintf('jump if zero\n')
                        addBlock(blockhandle,'jump if zero',destHandle.getJumpDest());
                    elseif (r==15) && (c==4) %jump if negative
                        fprintf('jump if negative\n')
                        addBlock(blockhandle,'jump if negative',destHandle.getJumpDest());
                    elseif (r==15) && (c==6) %jump
                        fprintf('jump\n')
                        addBlock(blockhandle,'jump',destHandle.getJumpDest());
                    end
                elseif (r==1)
                    if (c==1) %quit button
                        fprintf('quit\n')
                        status = -1; %exits the level
                    elseif c==9 %run button
                        fprintf('run\n')
                        updateArrays(obj.interpret,obj.levelScreenBGArray,obj.levelScreenArray,obj.editorWindowArray);
                        if ~obj.runned %if the program hasnt been run yet
                            obj.runned = true;
                            run(obj.interpret);
                            obj.levelScreenArray = obj.interpret.levelArray; %retrieves the outbox values
                        else
                            displayMsg('Reset the level to run again');
                        end
                    elseif c==10 %pause button
                        fprintf('pause\n') %this doesnt do anything since pause only works when running program
                    elseif c==11 %reset button
                        fprintf('reset\n')
                        obj.levelScreenArray = arrayMaker.getLevelScreenArray(obj.level); %gets new inbox values
                        obj.runned = false; %resets runned status
                        title('') %clears any messages
                    end
                elseif(r>1) && (c>8) %if mouse is clicked in the editor window
                    if obj.levelScreenBGArray(r,10) ~= 1 %if the mouse is clicked in the dest block column and the row isnt empty
                        if (obj.levelScreenBGArray(r,10)==66) %if it is the destination of a jump block
                            updateDest(blockhandle,r,destHandle.getJumpDest());
                        else %if it is the destination of a register block
                            updateDest(blockhandle,r,destHandle.getRegisterDest());
                        end
                        fprintf('block window\n')
                        fprintf('line %d\n',r-1)
                    end
                    fprintf('editor window\n')
                    fprintf('line %d\n',r-1)
                end
                obj.editorWindowArray = blockhandle.editorArray;
                obj.linePointer = blockhandle.linePointer;
                obj.levelScreenBGArray = blockhandle.BGArray;
            end
            eventNum = status;
        end
    end
end
