classdef arrayMaker
    methods (Static)
        function BGArray = getBGArray()
            BGArray = [82,1,1,1,1,1,1,71,79,80,81;
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
            1,57,1,58,1,83,1,70,1,1,1;
            1,59,1,60,1,102,1,70,1,1,1;
            1,61,1,62,1,103,1,70,1,1,1;
            1,63,1,64,1,65,1,70,1,1,1];
        end
        function editorWindowArray = getEditorWindowArray()
            editorWindowArray = [101,101,101,101,101,101,101,101,101,101,101;
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
        function array = getLevelScreenArray(level)
            temp = (zeros(15,11)+101);
            switch level
                case 1
                    for i=3:9
                        temp(i,2) = randi(25)+6;
                    end
                case 2
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
            end
            array = temp;
        end
    end
end
