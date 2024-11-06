classdef blockHandler < handle
    properties
        levelArray;
        editorArray;
        linePointer;
    end
    methods
        function obj = blockHandler(levelArray,editorArray,linePointer)
            obj.levelArray = levelArray;
            obj.editorArray = editorArray;
            obj.linePointer = linePointer;
        end

        function addBlock(obj,blockID,destbockID,destValID)
            obj.editorArray((obj.linePointer+1),9) = blockID;
            if nargin>2
                obj.levelArray((obj.linePointer+1),10) = destbockID;
                obj.editorArray((obj.linePointer+1),10) = destValID;
            end
            obj.linePointer = obj.linePointer + 1;
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
