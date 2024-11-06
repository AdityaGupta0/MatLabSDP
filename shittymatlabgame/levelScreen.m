classdef levelScreen < handle
    properties
        level;
        screen;
        levelScreenBGArray;
        level1ScreenArray;
        level2ScreenArray;
        level3ScreenArray;
        level4ScreenArray;
        editorWindowArray;
        linePointer;

        %levelScreenArrays = {level1ScreenArray};
    end
    methods
        function obj = levelScreen(level,screen)
            obj.level = level;
            obj.screen = screen;
            obj.linePointer = 1;
            obj.level1ScreenArray = [101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,20,101,101,101,101,101,101,101,101,101;
                            101,17,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101;
                            101,101,101,101,101,101,101,101,101,101,101];
            obj.levelScreenBGArray = [82,1,1,1,1,1,1,71,79,80,81;
                                    1,74,1,73,1,75,1,71,1,1,1;
                                    1,72,1,72,1,72,1,71,1,1,1;
                                    1,72,1,76,1,72,1,71,1,1,1;
                                    1,72,1,72,1,72,1,71,1,1,1;
                                    1,72,1,77,1,72,1,71,1,1,1;
                                    1,72,1,72,1,72,1,71,1,1,1;
                                    1,72,1,78,1,72,1,71,1,1,1;
                                    1,72,1,72,1,72,1,71,1,1,1;
                                    1,1,1,1,1,1,1,71,1,1,1;
                                    69,69,69,69,69,69,69,71,1,1,1;
                                    1,57,1,58,1,1,1,70,1,1,1;
                                    1,59,1,60,1,83,1,70,1,1,1;
                                    1,61,1,62,1,1,1,70,1,1,1;
                                    1,63,1,64,1,65,1,70,1,1,1];
            obj.editorWindowArray = [101,101,101,101,101,101,101,101,101,101,101;
                                        101,101,101,101,101,101,101,7,101,101,101;
                                        101,101,101,101,101,101,101,8,101,101,101;
                                        101,101,101,101,101,101,101,9,101,101,101;
                                        101,101,101,101,101,101,101,10,101,101,101;
                                        101,101,101,101,101,101,101,11,101,101,101;
                                        101,101,101,101,101,101,101,12,101,101,101;
                                        101,101,101,101,101,101,101,13,101,101,101;
                                        101,101,101,101,101,101,101,14,101,101,101;
                                        101,101,101,101,101,101,101,15,101,101,101;
                                        101,101,101,101,101,101,101,16,101,101,101;
                                        101,101,101,101,101,101,101,17,101,101,101;
                                        101,101,101,101,101,101,101,18,101,101,101;
                                        101,101,101,101,101,101,101,19,101,101,101;
                                        101,101,101,101,101,101,101,20,101,101,101];
        end

        function array = getLevelScreenBGArray(obj)
            array = obj.levelScreenBGArray;
        end

        function array = getLevelScreenArray(obj)
            array = obj.level1ScreenArray;
        end

        function array = getEditorWindowArray(obj)
            array = obj.editorWindowArray;
        end
        function setLevelScreenArray(obj,array)
            obj.level1ScreenArray = array;
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
                    blockhandle = blockHandler(obj.level1ScreenArray,obj.editorWindowArray,obj.linePointer);
                    temp =1;
                    if (r==12) && (c==2) %inbox
                        fprintf('inbox\n')
                        addBlock(blockhandle,57);
                    elseif (r==12) && (c==4) %outbox
                        fprintf('outbox\n')
                    elseif (r==13) && (c==2) %add
                        fprintf('add\n')
                    elseif (r==13) && (c==4) %sub
                        fprintf('sub\n')
                    elseif (r==13) && (c==6) %backspace
                        fprintf('backspace\n')
                        removeBlock(blockhandle);
                    elseif (r==14) && (c==2) %copyfrom
                        fprintf('copyfrom\n')
                    elseif (r==14) && (c==4) %copyto
                        fprintf('copyto\n')
                    elseif (r==15) && (c==2) %jump if zero
                        temp=2;
                        fprintf('jump if zero\n')
                        jumphandle=jumpHandler(obj.screen,obj.levelScreenBGArray,obj.level1ScreenArray,obj.editorWindowArray);
                        fprintf('line %d\n',getLineNum(jumphandle))
                    elseif (r==15) && (c==4) %jump if negative
                        temp=2;
                        jumphandle=jumpHandler(obj.screen,obj.levelScreenBGArray,obj.level1ScreenArray,obj.editorWindowArray);
                        fprintf('line %d\n',getLineNum(jumphandle))
                    elseif (r==15) && (c==6) %jump
                        temp=2;
                        fprintf('jump\n')
                        jumphandle=jumpHandler(obj.screen,obj.levelScreenBGArray,obj.level1ScreenArray,obj.editorWindowArray);
                        fprintf('line %d\n',getLineNum(jumphandle))
                    end
                    obj.editorWindowArray = blockhandle.editorArray;
                    obj.linePointer = blockhandle.linePointer;
                    obj.level1ScreenArray = blockhandle.levelArray;
                elseif (r==1)
                    if (c==1) %quit button
                        fprintf('quit\n')
                        temp = -1;
                    elseif c==9 %run button
                        fprintf('run\n')
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