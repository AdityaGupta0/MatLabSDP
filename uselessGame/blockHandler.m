classdef blockHandler < handle
    properties
        levelArray;
        editorArray;
        linePointer;
        blockMap;
        registerMap;
    end
    methods
        function obj = blockHandler(levelArray,editorArray,linePointer)
            obj.levelArray = levelArray;
            obj.editorArray = editorArray;
            obj.linePointer = linePointer;
            blockIDs = {'inbox','outbox','add','sub','copyfrom','copyto','jump if zero','jump if negative','jump','bump+','bump-'};
            blockValues = {[57],[58],[59,68],[60,68],[61,67],[62,67],[63,66],[64,66],[65,66],[102,104],[103,104]};
            obj.blockMap = containers.Map(blockIDs,blockValues); %hashmap for block values
        end

        function addBlock(obj,blockID,destVal)
            temp = obj.blockMap(blockID);
            obj.editorArray((obj.linePointer+1),9) = temp(1);
            if nargin>2
                obj.levelArray((obj.linePointer+1),10) = temp(2); 
                if destVal<0
                    destVal = (-destVal)+1; %converts register adress to name
                else 
                    destVal = destVal+6; %converts to line destination number
                end
                obj.editorArray((obj.linePointer+1),10) = destVal;
            end
            if obj.linePointer<15 %makes sure the line pointer doesn't go above 15
                obj.linePointer = obj.linePointer + 1;
            end
        end
        function removeBlock(obj)
            obj.editorArray((obj.linePointer),9) = 101;
            obj.levelArray((obj.linePointer),10) = 101;
            obj.editorArray((obj.linePointer),10) = 101;
            if obj.linePointer>1 %makes sure the line pointer doesn't go below 1
                obj.linePointer = obj.linePointer - 1;
            end
        end
    end
end
