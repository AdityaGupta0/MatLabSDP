clear
screen = simpleGameEngine('CompleteSpriteSheet.png',512,512,1);
repeat = true;
drawScene(screen, [100]);
getMouseInput(screen);

levelSelectScreen = levelSelectScreen();

while repeat
    drawScene(screen,levelSelectScreen.levelSelectSceneArray);
    [r,c,b] = getMouseInput(screen);
    level = levelSelectScreen.getSelectedLevel(r,c,b);
    display(level);
    pause(1);
end


