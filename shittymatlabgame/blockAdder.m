classdef blockAdder < handle
    properties
        levelArray;
        editorArray;
        nextLine;
    end
    methods
        function obj = blockAdder(levelArray,editorArray,nextLine)
            obj.levelArray = levelArray;
            obj.editorArray = editorArray;
            obj.nextLine = nextLine;
        end

        function addBlock(obj,blockID,destbockID,destValID)
            obj.editorArray((obj.nextLine+1),9) = blockID;
            if nargin>2
                obj.levelArray((obj.nextLine+1),10) = destbockID;
                obj.editorArray((obj.nextLine+1),10) = destValID;
            end
            obj.nextLine = obj.nextLine + 1;
        end
    end
end
