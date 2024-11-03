clear

level1Scene = simpleGameEngine('CompleteSpriteSheetV3.png',512,512,2);

%width 21
level1BackGroundArray = [
                        82,83,83,83,83,83,83,83,83,83,83,83,83,83,71,83,83,83;
                        83,83,75,83,83,83,83,83,83,83,76,83,83,83,71,80,81,83;
                        83,83,73,83,83,83,74,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,73,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,83,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,77,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,73,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,83,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,78,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,73,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,83,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,79,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,73,83,83,83,73,83,83,83,73,83,83,83,71,83,83,83;
                        83,83,83,83,83,83,83,83,83,83,83,83,83,83,71,83,83,83;
                        70,70,70,70,70,70,70,70,70,70,70,70,70,70,71,83,83,83;
                        83,83,83,61,83,83,62,83,83,63,83,83,83,83,71,83,83,83;
                        83,83,83,64,83,83,65,83,83,66,83,83,83,83,71,83,83,83;
                        83,83,83,67,83,83,68,83,83,69,83,83,83,83,71,83,83,83;
                        83,83,83,83,83,83,83,83,83,83,83,83,83,83,71,83,83,83];
bb = 100;
level1ForeGroundArray = [
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,85,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,86,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,87,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,88,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,89,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,91,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,92,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,93,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,94,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,95,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,96,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,97,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,98,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,99,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb;
                        bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb,bb];

drawScene(level1Scene,level1BackGroundArray,level1ForeGroundArray)

