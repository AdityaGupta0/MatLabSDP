clear
screen = simpleGameEngine('CompleteSpriteSheet.png',512,512,1);
repeat = true;
drawScene(screen, [100]);
getMouseInput(screen);

levelSelectScreen = levelSelectScreen();

while true
    drawScene(screen,levelSelectScreen.levelSelectSceneArray);
    [r,c,b] = getMouseInput(screen);
    level = levelSelectScreen.getSelectedLevel(r,c,b);

    levelScreen = levelScreen(level);
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    pause(100);
end


