classdef levelSelectScreen
    properties
        levelSelectSceneArray
    end
    methods (Static)
        function obj = levelSelectScreen()
            obj.levelSelectSceneArray = [1,94,95,1;           
                                         1,96,97,1;
                                         1,98,99,1;
                                         1,1,1,1];
        end
        function levelSelectSceneArray = getLevelSelectSceneArray()
        end
        function int = getSelectedLevel(r,c,b)
            if b == 1 && (r==2)
                if c == 2
                    int = 1;
                elseif c == 3
                    int = 2;
                end
            elseif b == 1 && (r==3)
                if c == 2
                    int = 3;
                elseif c == 3
                    int = 4;
                end
            end    
        end
    end
end