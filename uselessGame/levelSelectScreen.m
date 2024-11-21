classdef levelSelectScreen < handle %class for the level select screen and the maps all user inputs to the correct functions
    properties
        levelSelectSceneArray
    end
    methods (Static)
        function obj = levelSelectScreen()
            obj.levelSelectSceneArray = [1,94,95,115,82;           
                                        1,96,97,98,1;
                                        1,99,105,106,1;
                                        1,107,108,109,1
                                        1,111,112,113,1;
                                        1,1,1,1,1];
        end
        function levelSelectSceneArray = getLevelSelectSceneArray()
            levelSelectSceneArray = obj.levelSelectSceneArray;
        end
        function int = getSelectedLevel(screen,soundEffectPlayer) %returns the level selected by the user
            level=0;
            while level==0
                [r,c,b] = getMouseInput(screen);
                play(soundEffectPlayer); %plays the sound effect
                if b==1
                    switch r %i swear there was no cleaner way to do this im sorry
                        case 1
                            switch c
                                case 4
                                    level = 13; %free play
                                case 5
                                    level = -1; %quit button
                            end
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
        function fact = getFunFact() %chooses a random fun fact to display on the level select screen
            facts(1) = "Computer scientists know how to program in multiple lanuages";
            facts(2) = "Computer scientists are the architects of the digital world";
            facts(3) = "Every feild of engineering uses some aspect of computer science";
            facts(4) = "Computer scientists rarely work alone";
            facts(5) = "Computer engineers work on the hardware/firmware side of computers";
            facts(6) = "There are many unique specializations in Computer science";
            facts(7) = "Computer scientists have a massive impact on the world";
            facts(8) = "Computer scientists design and develop games";
            facts(9) = "Computer scientists work in cybersecurity to protect people";
            facts(10) = "Computer scientists work on AI to make computers smarter";
            facts(11) = "Mechanical engineers use computer science for simulation";
            facts(12) = "Matlab is a programming lanugage used by all engineers";
            facts(13) = "Computer scientists create applications for all types of devices";
            facts(14) = "Computer scientists make the operating systems that you use";
            facts(15) = "Computer scientists maintain and develop the internet";
            facts(16) = "Computer scientists need to be creative problem solvers";
            facts(17) = "Computer scientists utilize math to optimize algorithms";
            facts(18) = "Computer scientists work on the cutting edge of technology";
            facts(19) = "Software is everywhere, its even on the moon and mars (in rovers and probes)";
            facts(20) = "without computer engineers the modern world would not exist";
            fact = strcat("Fun Fact: ", facts(randi(length(facts)))); %returns random fact
            fprintf('%s\n',fact);
        end
    end
end