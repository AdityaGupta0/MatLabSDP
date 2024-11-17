classdef blockHandler < handle
    properties
        BGArray;
        editorArray;
        linePointer;
        blockMap;
        registerMap;
    end
    methods
        function obj = blockHandler(BGArray,editorArray,linePointer)
            obj.BGArray = BGArray;
            obj.editorArray = editorArray;
            obj.linePointer = linePointer;
            blockIDs = {'inbox','outbox','add','sub','copyfrom','copyto','jump if zero','jump if negative','jump','bump-','bump+'};
            blockValues = {[57],[58],[59,68],[60,68],[61,67],[62,67],[63,66],[64,66],[65,66],[102,104],[103,104]};
            obj.blockMap = containers.Map(blockIDs,blockValues); %hashmap for block values
        end
        function addBlock(obj,blockID,destVal)
            blockVal = obj.blockMap(blockID);
            obj.editorArray((obj.linePointer+1),9) = blockVal(1);
            if nargin>2
                obj.BGArray((obj.linePointer+1),10) = blockVal(2); 
                if destVal<0
                    destVal = (-destVal)+1; %converts register adress to name
                else 
                    destVal = destVal+6; %converts to line destination number
                end
                obj.editorArray((obj.linePointer+1),10) = destVal;
            end
            obj.linePointer = obj.linePointer + 1;
        end
        function removeBlock(obj)
            if obj.linePointer>1 %makes sure the line pointer doesn't go below 1
                obj.editorArray((obj.linePointer),9) = 101;
                obj.BGArray((obj.linePointer),10) = 1; %since this is part of the background array, it needs to be reset to blank not transparent
                obj.editorArray((obj.linePointer),10) = 101;
                obj.linePointer = obj.linePointer - 1;
            end
        end
        function updateDest(obj,lineNum, destVal)
            if destVal<0
                destVal = (-destVal)+1;
            else 
                destVal = destVal+6;
            end
            obj.editorArray(lineNum,10) = destVal;
        end
    end
end
