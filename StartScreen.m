clear

startScreen = simpleGameEngine('sprite_sheet.png',512,512,1,[0,0,245]);
startScreenArray = [1,2,1;1,3,1;1,1,1];
drawScene(startScreen,startScreenArray)


%Determine which sprite was clicked
% r = row, c= column, b = button (1 = left, 2 = middle, 3 = right)
[r,c,b] = getMouseInput(startScreen);

%If the left mouse button is clicked, flip over the card that was
%clicked

levelSelectScene = simpleGameEngine('Level_select_sprite_sheet.png',512,512,1);
levelselectArray = [1,5,6,1,1;1,7,8,9,1;1,10,11,12,1;1,2,3,4,1;1,1,1,1,1];
if b == 1 && (512<c<1024) && (512<r<1024)
    drawScene(levelSelectScene,levelselectArray)
end