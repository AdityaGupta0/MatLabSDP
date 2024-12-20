%% drawCard function

% drawCard parameter are:
% draw - number of cards to draw
% w - who to draw the cards for (1 for player, 2 for opponent)
function [] = drawCard(draw,w)

global deck;
global numAces;
global total;
global cards;

len = length(cards);

% draw - 'draw' number of cards
for c = 1:draw

    % get random numbers 2-14 for value (ace is 14)
    % get random numbers 1-4 for suit
    value = randi([2, 14],1);
    suit = randi([1,4],1);
    
    % checking if cards have been drawn already
    % if so, continue until valid
    while deck(value-1,suit) == false
        value = randi([2, 14],1);
        suit = randi([1,4],1);
    end

    % add cards to cards[] array, to store
    cards(1,len+c, w) = value;
    cards(2,len+c, w) = suit;

    % determine total based on card type
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
    
    % remove card from deck
    deck(value-1,suit) = false;

    % calculation to change value of ace if over 21
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