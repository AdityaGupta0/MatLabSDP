classdef levelScreen
    properties
        levelScene;
        levelScreenBGArray;
        level1ScreenArray = [];
        level2ScreenArray = [];

        levelScreenArrays = {level1ScreenArray,level2ScreenArray};
    end
    methods
        function obj = levelScreen(obj)
            obj.levelScene = obj;
            
        end
        function int = launchLevelScreen(level)
            drawScene(levelScreen,levelScreenBGArray,levelScreenArrays(level));
            [r,c,b] = getMouseInput(levelScreen);
            if b == 1 && (c==2) && (r==2)
                int = 1;
            end
        end
    end
end