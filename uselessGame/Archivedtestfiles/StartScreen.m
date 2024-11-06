clear
%display splash start screen
startScreen = simpleGameEngine('sprite_sheet.png',512,512,1,[0,0,245]);
startScreenArray = [1,2,1;1,3,1;1,1,1];
drawScene(startScreen,startScreenArray)
title('Press Start to Play')

%Determine which sprite was clicked
% r = row, c= column, b = button (1 = left, 2 = middle, 3 = right)
[r,c,b] = getMouseInput(startScreen);

levelSelectScene = simpleGameEngine('sprite_sheet.png',512,512,0.5); 
levelselectArray = [1,5,6,1,1;
                    1,7,8,9,1;
                    1,10,11,12,1;
                    1,2,3,4,1;
                    1,1,1,1,1];

if b == 1 && (c==2) && (r==2) %detects if the user clicked the play button 
    drawScene(levelSelectScene,levelselectArray)
end
title('Select a level')


level1Scene = simpleGameEngine('sprite_sheet.png',512,512,1);
%width is 19
level1SceneArray = [58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,57,58,58;
                    58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58;
                    56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56;
                    58,47,58,48,58,49,58,50,58,51,58,52,58,53,58,54,58,55,58];
level1SceneArray = level1SceneArray+1;

[r,c,b] = getMouseInput(levelSelectScene);
if b == 1 && (c==2) && (r==2) %detects if the user clicked the level 1 button 
    drawScene(level1Scene,level1SceneArray)
end
title('Level 1 challenge')

%The only part i found challenging is dealing with large arrays to get the
%desired scene and resolution. I already have these scenes functioning in
%my game with more complex user input but that uses objective code so I 
% wouldnt get points as the input handling is done in seperate classes. I
% think i will discuss with my group about how we want to use the
% title/annotation functions as an aspect of the game as right now we relly
% heavily on sprites for conveying information. We could use the title for
% either static or dynamic informaiton but thats up for debate. 

