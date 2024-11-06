clear
screen = simpleGameEngine('CompleteSpriteSheet.png',512,512,1);
drawScene(screen, [100]);
getMouseInput(screen);

levelSelectScreen = levelSelectScreen();

while true
    clear levelScreen;
    repeat = true;
    drawScene(screen,levelSelectScreen.levelSelectSceneArray);
    [r,c,b] = getMouseInput(screen);
    level = levelSelectScreen.getSelectedLevel(r,c,b);

    levelScreen = levelScreen(level,screen);
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    while repeat
        [r,c,b] = getMouseInput(screen);
        eventNum = getClickEvent(levelScreen,r,c,b);
        if eventNum == -1 %quit condition
            repeat = false;
        end
        drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
        pause(1);
    end
    pause(1);
end


