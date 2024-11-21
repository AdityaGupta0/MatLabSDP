% This is the main file for the game. It will run the game and handle the logic of the game.
clc
clear
screen = betterGameEngine('CompleteSpriteSheet.png',512,512,1);
drawScene(screen, [100]);
getMouseInput(screen);
rungame = true;
levelSelectScreen = levelSelectScreen();

if exist('saveData.mat', 'file')
    % Load saved data
    load('saveData.mat', 'editorWindowArrayList', 'BGArrayList', 'linePointerArray');
else
    % Initialize arrays if no save file
    editorWindowArrayList = arrayMaker.getEditorWindowArrayList();
    BGArrayList = arrayMaker.getBGArrayList();
    linePointerArray = arrayMaker.getLinePointerArray();
end

[y,Fs] = audioread('Aditya Gupta SDP portfolio 3 MP3 compress.mp3'); %loads the music file
musicPlayer = audioplayer(y,Fs); %creates an audio player object
musicPlayer.StopFcn = @(~, ~) play(musicPlayer); %callback function that restarts music when it stops
play(musicPlayer);
% Load sound effect file for button clicks
[se_y, se_Fs] = audioread('CustomClickSoundforSDP.wav');
soundEffectPlayer = audioplayer(se_y, se_Fs);

while rungame %main game loop
    clear levelScreen; %clears the level screen object to prevent memory leaks
    repeat = true;
    drawScene(screen,levelSelectScreen.levelSelectSceneArray); %draws the level select screen
    title({'In computer science, engineers need to understand how low level code works';
    'as it is the foundation of all computer programs.';
    'This game will teach you the logic of assembly and VM code.';},...
        'Units', 'normalized', 'Position', [0.5, 0.09, 0], 'FontSize', 12);
    %gets a new random funfact to display
    text(1,1,[levelSelectScreen.getFunFact()],'Units','normalized','Position',[0.5, 0.06, 0],'HorizontalAlignment','center','FontSize',12);
    level = levelSelectScreen.getSelectedLevel(screen,soundEffectPlayer);
    if level == -1 %termination condition
        rungame = false;
        break;
    end
    levelScreen = levelScreen(level,screen); %creates a new level screen object using the selected level
    levelScreen.setLevelScreenBGArray(BGArrayList{level});
    levelScreen.setEditorWindowArray(editorWindowArrayList{level});
    levelScreen.setLinePointer(linePointerArray(level));
    drawScene(screen,getLevelScreenBGArray(levelScreen),getLevelScreenArray(levelScreen),getEditorWindowArray(levelScreen));
    while repeat
        text(55,512*9.25,arrayMaker.getLevelChallenge(level),'VerticalAlignment','top','HorizontalAlignment','left','FontSize',10);
        text(512*4.5,50,arrayMaker.getLevelName(level),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',12);  
        [r,c,b] = getMouseInput(screen); 
        play(soundEffectPlayer); %plays the sound effect
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
musicPlayer.StopFcn = @(~, ~) ''; %removes the callback function to prevent music from restarting
stop(musicPlayer);
fprintf('Game Terminated, progress saved.\n');
close all %closes the game window before program termination
save('saveData.mat', 'editorWindowArrayList', 'BGArrayList', 'linePointerArray');
