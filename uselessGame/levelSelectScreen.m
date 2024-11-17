classdef levelSelectScreen < handle
    properties
        levelSelectSceneArray
    end
    methods (Static)
        function obj = levelSelectScreen()
            obj.levelSelectSceneArray = [1,94,95,1,1;           
                                        1,96,97,98,1;
                                        1,99,105,106,1;
                                        1,107,108,109,1
                                        1,111,112,113,1;
                                        1,1,1,1,1];
        end
        function levelSelectSceneArray = getLevelSelectSceneArray()
            levelSelectSceneArray = obj.levelSelectSceneArray;
        end
        function int = getSelectedLevel(screen) %returns the level selected by the user
            level=0;
            while level==0
                [r,c,b] = getMouseInput(screen);
                if b==1
                    switch r %i swear there was no cleaner way to do this im sorry
                        case 2
                            switch c
                                case 2
                                    level = 1;
                                case 3
                                    level = 2;
                                case 4
                                    level = 3;
                            end
                        case 3
                            switch c
                                case 2
                                    level = 4;
                                case 3
                                    level = 5;
                                case 4
                                    level = 6;
                            end
                        case 4
                            switch c
                                case 2
                                    level = 7;
                                case 3
                                    level = 8;
                                case 4
                                    level = 9;
                            end
                        case 5
                            switch c
                                case 2
                                    level = 10;
                                case 3
                                    level = 11;
                                case 4
                                    level = 12;
                            end
                    end
                end
            end
            int = level;
        end
    end
end