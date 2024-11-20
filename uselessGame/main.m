% This is the main file for the game. It will run the game and handle the logic of the game.
clc
screen = betterGameEngine('CompleteSpriteSheet.png',512,512,1);
drawScene(screen, [100]);
getMouseInput(screen);
rungame = true;
levelSelectScreen = levelSelectScreen();
while rungame
    clear levelScreen; %clears the level screen object to prevent memory leaks
    repeat = true;
    drawScene(screen,levelSelectScreen.levelSelectSceneArray); %draws the level select screen
    title({'In computer science, engineers need to understand how low level code works';
    'as it is the foundation of all computer programs.';
    'This game will teach you the logic of assembly and VM code.';},...
        'Units', 'normalized', 'Position', [0.5, 0.09, 0], 'FontSize', 12);
    %gets a new random funfact to display
    text(1,1,[levelSelectScreen.getFunFact()],'Units','normalized','Position',[0.5, 0.06, 0],'HorizontalAlignment','center','FontSize',12);
    level = levelSelectScreen.getSelectedLevel(screen);
    if level == -1 %termination condition
        rungame = false;
        break;
    end
    levelScreen = levelScreen(level,screen); %creates a new level screen object using the selected level

    if ~exist('editorWindowArrayList','var') || ~exist('BGArrayList','var') || ~exist('linePointerArray','var') 
        %checks for prior level save, if not found, creates new cell arrays
        editorWindowArrayList = arrayMaker.getEditorWindowArrayList();
        BGArrayList = arrayMaker.getBGArrayList();
        linePointerArray = arrayMaker.getLinePointerArray();
    end
    levelScreen.setLevelScreenBGArray(BGArrayList{level});
    levelScreen.setEditorWindowArray(editorWindowArrayList{level});
    levelScreen.setLinePointer(linePointerArray(level));
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    while repeat
        text(55,512*9.25,arrayMaker.getLevelChallenge(level),'VerticalAlignment','top','HorizontalAlignment','left','FontSize',10);
        text(512*4.5,50,arrayMaker.getLevelName(level),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',12);  
        [r,c,b] = getMouseInput(screen); 
        eventNum = getClickEvent(levelScreen,r,c,b);
        if eventNum == -1 %quit condition
            repeat = false;
        end
        drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    end
    editorWindowArrayList{level} = getEditorWindowArray(levelScreen); %saves the level progress
    BGArrayList{level} = getLevelScreenBGArray(levelScreen);
    linePointerArray(level) = getLinePointer(levelScreen);
end
close all %closes the game window before program termination

