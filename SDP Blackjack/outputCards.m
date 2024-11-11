%% outputCards function

% *********************************************************
% ISNT USED ANYMORE - REPLAYED BY GRAHPIC OUTPUT FUNCTION
% **********************************************************

% only parameter for outputCards() is 
% output for player or opponent (1 for player, 2 for opponent)
function [] = outputCards(w)

global cards;
global total;

if w==1
    fprintf("Players Cards:\n")
elseif w==2
    fprintf("Opponent's Cards:\n")
end

numCards=0;

for c = 1:size(cards, 2)

    value = cards(1,c,w);
    suit = cards(2,c,w);
    
    whatCard = '';

    switch value
        case 11
            whatCard = strcat(whatCard, 'Jack');
        case 12
            whatCard = strcat(whatCard, 'Queen');
        case 13
            whatCard = strcat(whatCard, 'Queen');
        case 14
            whatCard = strcat(whatCard, 'Ace');
        otherwise
            whatCard = strcat(whatCard, num2str(value));
    end
    
    switch suit
        case 1
            whatCard = strcat(whatCard, ' of Hearts');
        case 2
            whatCard = strcat(whatCard, ' of Diamonds');
        case 3
            whatCard = strcat(whatCard, ' of Clubs');
        case 4
            whatCard = strcat(whatCard, ' of Spades');
    end
    
    if value ~= 0 && suit ~= 0
        fprintf('\t%s\n',whatCard);
        
        numCards = numCards + 1;
    end


    clear value
    clear suit
end

clear c
clear whatCard

if w==1
    fprintf('\tTotal: %d\n', total(1))
elseif w==2 & numCards==1
    fprintf("\t?????\n")
elseif w==2
    fprintf('\tTotal: %d\n\n', total(2))
end

end