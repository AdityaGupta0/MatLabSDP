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
                case 1 %level 1, generates 2 random positive numbers
                    for i=3:5
                        temp(i,2) = randi(25)+6;
                    end
                case 2 %level 2, generates 2 random numbers
                    for i=3:5
                        temp(i,2) = randi(50)+6;
                    end
                case 3 %level 3 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 4 %level 4 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 5 %level 5 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 6 %level 6 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 7 %level 7 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 8 %level 8 edit later
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
                case 9 %level 9 generate 7 random numbers
                    for i=3:9
                        temp(i,2) = randi(50)+6;
                    end
            end
            array = temp;
        end
        function challenge = getLevelChallenge(level)
            switch level
                case 1
                    challenge = 'Use the inbox and outbox commands to move all the numbers from the inbox to the outbox';
                case 2
                    challenge = 'Use the add command to add the first two numbers in the inbox and move the result to the outbox';
                case 3
                    challenge = '';
                case 4
                    challenge = '';
                case 5
                    challenge = '';
                case 6
                    challenge = '';
                case 7
                    challenge = '';
                case 8
                    challenge = '';
                case 9
                    challenge = 'Free play';
            end
        end
    end
end
