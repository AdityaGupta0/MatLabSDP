%% drawCard function

% drawCard parameter are:
% number of cards to draw
% who to draw the cards for (1 for player, 2 for opponent)
function [] = drawCard(draw,w)

global deck;
global numAces;
global total;
global cards;

len = length(cards);

for c = 1:draw

    value = randi([2, 14],1);
    %value = 9;
    suit = randi([1,4],1);
    
    % While the card is not in the deck, draw another
    while deck(value-1,suit) == false
        value = randi([2, 14],1);
        suit = randi([1,4],1);
    end

    cards(1,len+c, w) = value;
    cards(2,len+c, w) = suit;

    switch value
        case 11
            total(w) = total(w)+10;
        case 12
            total(w) = total(w)+10;
        case 13
            total(w) = total(w)+10;
        case 14
            total(w) = total(w)+11;
            numAces(w) = numAces(w) + 1;
        otherwise
            total(w) = total(w) + value;
    end
    
    deck(value-1,suit) = false;

    if total(w)>21 && numAces(w)>0
        total(w) = total(w) - 10;
        numAces(w) = numAces(w) - 1;
    end
end

clear c
clear value
clear suit
clear len
clear draw

end