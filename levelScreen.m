classdef levelScreen
    properties
        level;
        levelScreenBGArray;
        level1ScreenArray = [];
        level2ScreenArray = [];
        level3ScreenArray = [];
        level4ScreenArray = [];

        levelScreenArrays = {level1ScreenArray,level2ScreenArray};
    end
    methods
        function obj = levelScreen(level)
            obj.levelScene = level;
        end
        function levelScreenBGArray = getLevelScreenBGArray(level)
        end
        function array = getLevelScreenArray()
            array = levelScreenArrays{level};
        end
    end
end