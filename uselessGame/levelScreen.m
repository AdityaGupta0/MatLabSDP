classdef levelScreen < handle
    properties
        level;
        screen;
        levelScreenBGArray;
        levelScreenArray
        editorWindowArray;
        linePointer;
        interpret;
    end
    methods
        function obj = levelScreen(level,screen)
            obj.screen = screen;
            obj.linePointer = 1;
            obj.levelScreenArray = arrayMaker.getLevelScreenArray(level);
            obj.levelScreenBGArray = arrayMaker.getBGArray();
            obj.editorWindowArray = arrayMaker.getEditorWindowArray();
            obj.interpret = interpreter(obj.screen,obj.levelScreenBGArray,obj.levelScreenArray,obj.editorWindowArray);
        end
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
        function eventNum = getClickEvent(obj,r,c,b)
            temp = 0;
            if b==1
                if (r>11) && (c<7) %if mouse is clicked in the block select window
                    blockhandle = blockHandler(obj.levelScreenArray,obj.editorWindowArray,obj.linePointer);
                    destHandle = destHandler(obj.screen,obj.levelScreenBGArray,obj.levelScreenArray,obj.editorWindowArray);
                    temp =1;
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
                        temp=2;
                        fprintf('jump if zero\n')
                        addBlock(blockhandle,'jump if zero',destHandle.getJumpDest());
                    elseif (r==15) && (c==4) %jump if negative
                        temp=2;
                        fprintf('jump if negative\n')
                        addBlock(blockhandle,'jump if negative',destHandle.getJumpDest());
                    elseif (r==15) && (c==6) %jump
                        temp=2;
                        fprintf('jump\n')
                        addBlock(blockhandle,'jump',destHandle.getJumpDest());
                        
                    end
                    obj.editorWindowArray = blockhandle.editorArray;
                    obj.linePointer = blockhandle.linePointer;
                    obj.levelScreenArray = blockhandle.levelArray;
                    updateEditorWindowArray(obj.interpret,obj.editorWindowArray);
                elseif (r==1)
                    if (c==1) %quit button
                        fprintf('quit\n')
                        temp = -1;
                    elseif c==9 %run button
                        fprintf('run\n')
                        run(obj.interpret);
                        obj.levelScreenArray = obj.interpret.levelArray;
                    elseif c==10 %pause button
                        fprintf('pause\n') %maybe consider doing a step instead of pause
                    elseif c==11 %reset button
                        fprintf('reset\n')
                    end
                elseif(r>1) && (c>8) %if mouse is clicked in the editor window
                    fprintf('editor window\n')
                    fprintf('line %d\n',r-1)
                end
            end
            eventNum = temp;
        end
    end
end