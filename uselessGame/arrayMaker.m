classdef arrayMaker %static class for generating arrays for the level screens and prompts. 
    properties (Constant)
        baseEditorArray = [101,101,101,101,101,101,101,101,101,101,101;
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
        BGArray = [82,114,1,1,1,1,1,70,79,80,81;
            1,74,1,73,1,75,1,70,1,1,1;
            1,72,1,72,1,72,1,70,1,1,1;
            1,72,1,76,1,72,1,70,1,1,1;
            1,72,1,72,1,72,1,70,1,1,1;
            1,72,1,77,1,72,1,70,1,1,1;
            1,72,1,72,1,72,1,70,1,1,1;
            1,72,1,78,1,72,1,70,1,1,1;
            1,72,1,72,1,72,1,70,1,1,1;
            1,1,1,1,1,1,1,70,1,1,1;
            69,69,69,69,69,69,69,71,1,1,1;
            1,57,1,58,1,83,1,70,1,1,1;
            1,59,1,60,1,102,1,70,1,1,1;
            1,61,1,62,1,103,1,70,1,1,1;
            1,63,1,64,1,65,1,70,1,1,1];
    end
    methods (Static)
        function BGArray = getBGArray() %returns the background array which has the sprites for buttons and static ui elements
            BGArray = arrayMaker.BGArray;
        end
        function BGArrayList = getBGArrayList() %returns the background array for each level
            BGArrayList = repmat({arrayMaker.BGArray},1,13);
        end
        function editorWindowArrayList = getEditorWindowArrayList() %transparent except for the line numbers
            editorWindowArrayList = repmat({arrayMaker.baseEditorArray},1,13);
        end
        function editorWindowArray = getEditorWindowArray()
            editorWindowArray = arrayMaker.baseEditorArray;
        end
        function linePointerArray = getLinePointerArray()
            linePointerArray = ones(1,13);
        end
        function array = getLevelScreenArray(level) %parametric random number generation 
            randArray = (zeros(15,11)+101);
            switch level
                case 1 %level 1, generates 2 random positive numbers
                    for i=3:4
                        randArray(i,2) = randi(25)+6;
                    end
                case 2 %level 2, generates 7 random numbers
                    for i=3:9
                        randArray(i,2) = randi(50)+6;
                    end
                case 3 %level 3, generates 1 random number
                        randArray(3,2) = randi(50)+6;
                case 4 %level 4, generates 6 random numbers
                    for i=3:8
                        randArray(i,2) = randi(50)+6;
                    end
                case 5 %level 5, generates 6 random positive numbers less than 12
                    for i=3:8
                        randArray(i,2) = randi(12)+6;
                    end
                case 6 %level 6, generate 7 numbers, with a bias for zero 
                    for i=3:9
                        if rand>0.4
                            randArray(i,2) = randi(49)+7;
                        else
                            randArray(i,2) = 6;
                        end
                    end
                case 7 %level 7 generates 1 and 0, then 5 random numbers
                    randArray(3,2)=6;
                    randArray(4,2)=7;
                    for i=5:9
                        randArray(i,2) = randi(50)+6;
                    end
                case 8 %level 8 generates 6 random positive numbers
                    for i=3:8
                        randArray(i,2) = randi(25)+6;
                    end
                case 9 %level 9 generates 6 random positive numbers
                    for i=3:8
                        randArray(i,2) = randi(25)+6;
                    end
                case 10 %level 10 generates 7 random numbers with at least one negative
                    for i=3:9
                        randArray(i,2) = randi(50)+6;
                    end
                    a=(randi(7)+2); %chooses random number to be negative
                    if randArray(a,2)<31 
                        randArray(a,2) = randArray(a,2)+25;
                    end
                case 11 %level 11 generates 7 random numbers with at least one being zero and one being negative
                    for i=3:7
                        if rand>0.5
                            randArray(i,2) = randi(5)+7;
                        else
                            randArray(i,2) = randi(5)+32;
                        end
                    end
                    a=(randi(5)+2); %chooses random number to be zero
                    if randArray(a,2)~=6 %randomly makes a number zero
                        randArray(a,2) = 6;
                    end
                case 12 %level 12 generates 6 random positive numbers less than 6
                    for i=3:8
                        randArray(i,2) = randi(5)+6;
                    end
                case 13 %free play generates 7 random numbers
                    for i=3:9
                        randArray(i,2) = randi(50)+6;
                    end
            end
            array = randArray;
        end
        function challenge = getLevelChallenge(level) 
            switch level
                case 1
                    challenge = {'Move all the numbers in the inbox to the outbox. Click on the'; 
                    'inbox and outbox blocks to add them to your program.'; 
                    'Click the play button to run your program.'; 
                    'If you fail, try again by clicking the restart button.'};
                case 2
                    challenge = {"Repition is helpful for computer engineers."; 
                                "Output everything in the inbox."; 
                                "Instead of using 14 blocks, use the jump block."; 
                                "The jump block will go to the line that you enter."};
                case 3
                    challenge = {"In computers, there are registers (RAM) to temporarily store";
                                "information so that a program can manipulate the values."; 
                                "Use the CopyTo and CopyFrom blocks to Output the number";
                                "in the inbox two times."
                                "Tip: You can edit blocks with destinations by clicking on them."};
                case 4
                    challenge = {"Computer scientists work at the forefront of security which";
                                "often involves scrambling/encrpyting data."; 
                                "Take the first two numbers in the inbox, reverse them,"; 
                                "and then output them. Repeat this until the inbox is empty."};
                case 5
                    challenge = {"Computers have an ALU (Arithmatic logic unit) that allows"; 
                                "them to do basic math.";
                                "For every two things in the inbox, add them together"; 
                                "and then outbox the result."};
                case 6
                    challenge = {"Condtional statements are elementary to computer science and"; 
                                "allow computers make descisions."; 
                                "Use the Jump if zero block to output all numbers that aren't zero."; 
                                "Hint: the Jump if zero block checks the value in ARG"};
                case 7
                    challenge = {"Heres an example of how regsiters can be used in computers."; 
                                "Inbox the 1 and 0 into THIS and THAT.";
                                "For all the remaining values, output a zero if they are";
                                "negative and output 1 if they are positive."};
                case 8
                    challenge = {"For each two values in the inbox, use the Sub block to subtract"; 
                                "the first value from the second and output the result"; 
                                "before subtracting the second from the first and outputting"; 
                                "the result. Repeat for the entire inbox."};
                case 9
                    challenge = {"These blocks are limiting, but computer scientists have to" 
                                "work around limitations in expression. Compare every two values" 
                                "in the inbox with each other, and output the greatest of the two."; 
                                "If they are the same output either one."};
                case 10
                    challenge = {"Computer scientists often work with user inputs that" 
                                "need to be modified/cleaned before being used.";
                                "Output all the values from the inbox, but make sure all"
                                "values are positive."};
                case 11
                    challenge = {"Computer scientists have often have to calculate time."; 
                                "For each value in the inbox, countdown to zero (or up to";
                                "if negative), outboxing each number along the way."; 
                                "The bump blocks add or subtract one from a register";
                                "and the value in LCL."};
                case 12 
                    challenge = {"The ALU we earlier can only add and subtract, but engineers";
                                "need the ability to multiply numbers.";
                                "For each two values in the inbox, multiply them together";
                                "and outbox the result. Don't worry about negative numbers."};
                case 13 %free play
                    challenge = {"No Challenge here, just experiment and have fun!"; 
                                "Tip: You can click on blocks to edit them.";};
            end
        end
        function name = getLevelName(level)
            switch level
                case 1
                    title = 'Introduction';
                case 2
                    title = 'Repeat After Me';
                case 3
                    title = 'Copycat Copycat';
                case 4
                    title = 'Poached or Scrambled?';
                case 5
                    title = 'Addition Junction';
                case 6
                    title = 'Zero Exterminator';
                case 7
                    title = 'Binary Converter';
                case 8
                    title = 'Subtraction Station';
                case 9
                    title = 'Number Maxxing';
                case 10
                    title = 'Absolute Positivity';
                case 11
                    title = 'The Final Countdown';
                case 12
                    title = 'Multiplication Haven';
                case 13
                    title = 'Free Play!';
                    level = 0;
            end
            name = sprintf('Level %d: %s',level,title);
        end
    end
end
