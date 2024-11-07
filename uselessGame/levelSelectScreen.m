classdef levelSelectScreen < handle
    properties
        levelSelectSceneArray =[1,94,95,1;           
                                1,96,97,1;
                                1,98,99,1;
                                1,1,1,1];
    end
    methods (Static)
        function obj = levelSelectScreen()
        end
        function levelSelectSceneArray = getLevelSelectSceneArray()
        end
        function int = getSelectedLevel(screen) %TODO REWRITE THIS FUNCTION TO ACTUALLY TAKE MOUSE INPUT
            level=0;
            while level==0
                [r,c,b] = getMouseInput(screen);
                if b==1
                    if r==2
                        if c==2
                            level = 1;
                        elseif c==3
                            level = 2;
                        end
                    elseif r==3
                        if c==2
                            level = 3;
                        elseif c==3
                            level = 4;
                        end
                    end
                end
            end
            int = level;
        end
    end
end