% This is the main file for the game. It will run the game and handle the logic of the game.
clear
screen = betterGameEngine('CompleteSpriteSheet.png',512,512,1);
drawScene(screen, [100]);
getMouseInput(screen);
rungame = true;
levelSelectScreen = levelSelectScreen();
while rungame
    clear levelScreen;
    repeat = true;
    drawScene(screen,levelSelectScreen.levelSelectSceneArray);
    title({'In computer science, engineers need to understand how low level code works';
    'as it is the foundation of all computer programs.';
    'This game will teach you the logic of assembly and VM code.';
    'Low level code is size constrained so each program is limited to 14 lines of code'},...
        'Units', 'normalized', 'Position', [0.5, 0.07, 0], 'FontSize', 12);
    level = levelSelectScreen.getSelectedLevel(screen);
    if level == -1 %termination condition
        rungame = false;
        break;
    end
    levelScreen = levelScreen(level,screen);
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    while repeat
        text(55,512*9.25,arrayMaker.getLevelChallenge(level),'VerticalAlignment','top','HorizontalAlignment','left','FontSize',10);
        text(512,10,'Click on the blocks to add them to your program.','VerticalAlignment','top','HorizontalAlignment','left','FontSize',10);
        [r,c,b] = getMouseInput(screen);
        eventNum = getClickEvent(levelScreen,r,c,b);
        if eventNum == -1 %quit condition
            repeat = false;
        end
        drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    end
end
close all %closes the game window before program termination

