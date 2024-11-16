clear
screen = betterGameEngine('CompleteSpriteSheet.png',512,512,1);
drawScene(screen, [100]);
getMouseInput(screen);

levelSelectScreen = levelSelectScreen();
while true
    clear levelScreen;
    repeat = true;
    drawScene(screen,levelSelectScreen.levelSelectSceneArray);
    title({'In computer science, engineers need to understand how low level code works.';'This game will teach you the logic of assembly and VM code'},...
        'Units', 'normalized', 'Position', [0.5, 0.1, 0], 'FontSize', 12);
    level = levelSelectScreen.getSelectedLevel(screen);


    levelScreen = levelScreen(level,screen);
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    while repeat
        title(arrayMaker.getLevelChallenge(levelScreen.level));
        [r,c,b] = getMouseInput(screen);
        eventNum = getClickEvent(levelScreen,r,c,b);
        if eventNum == -1 %quit condition
            repeat = false;
        end
        drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    end
end


