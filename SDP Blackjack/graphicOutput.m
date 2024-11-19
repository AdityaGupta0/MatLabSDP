%%
% 0 - first cards
% 1 - you drawing cards
% 2 - opp drawing cards
% 3 - win/loose
% 4 - first cards are same (split)
function [] = graphicOutput(turn)
    global total;
    global cards;
    
    global luigi;
    
    % variables so I don't have to keep copy/pasting everytime
    l = [101:105; 111:115; 121:125; 131:135; 141:145];
    l_deal = [151:155; 161:165; 171:175; 181:185; 191:195];
    s = [106:110; 116:120; 126:130; 136:140; 156:160];
    g = [106:110; 116:120; 126:130; 136:140; 146:150];
    
    skip = [1,1,1,1,1; ...
        1,1,1,1,1; ...
        1,1,1,1,1; ...
        1,1,1,1,1; ...
        1,1,1,1,1];
    
%% gambling amount & menu    
if turn == -1
    drawScene(luigi,[l;g]);
else

    card = ones(1:4);
    lcard = ones(1:4);
    
    cardPos(1) = 0;
    

    %% player cards
    for c = 1:size(cards, 2)
        output = 21;
    
        value = cards(1,c,1);
        suit = cards(2,c,1);
    
        if value ~= 14
            output = output + value-1;
        end
        
        output = output + (suit-1) * 13;
        
        if value ~= 0 && suit ~= 0
            cardPos(1) = cardPos(1) + 1;
            card(cardPos(1)) = output;
        end
    
    
        clear value
        clear suit
    end
    
    cardPos(2) = 0;
    
    %% opp cards
    for c = 1:size(cards, 2)
        output = 21;
    
        value = cards(1,c,2);
        suit = cards(2,c,2);
    
        if value ~= 14
            output = output + value-1;
        end
        
        output = output + (suit-1) * 13;
        
        if value ~= 0 && suit ~= 0
            cardPos(2) = cardPos(2) + 1;
            lcard(cardPos(2)) = output;
        end
    
    
        clear value
        clear suit
    end
    
    %%
    if total(1) < 10
        score = [total(1) + 11, 1];
    elseif total(1) >= 10 && total(1) <= 21
        score = [total(1) - 10 + 81, 1];
    elseif total(1) > 21
        score = [93,94];
    end
    
    switch turn
        case 0
            if total(1) == 21
                message = [78,79,80];
            else
                message = [166,167,168];
            end
        case 1
            message = [166,167,168];
        case 2
            message = [1,1,1];
        case 3
            if total(1) == 21 && cardPos(1) == 2
                message = [78,79,80];
            elseif (total(1) > total(2) && total(1) <= 21) || total(2) > 21
                message = [77,1,1];
            elseif total(2) > total(1) || total(1) > 21
                message = [75,76,1];
            elseif total(1) == total(2)
                message = [97,1,1];
            end
        case 4
            if total(1) == 21
                message = [78,79,80];
            else
                message = [168, 169, 170];
            end
    end
    
    
    % it is actually possible to have 11 cards drawn so this is neccesary
    oppCards = [];
    switch cardPos(2)
        case 1
            oppCards = [1,1,lcard(1),4,1 ; 1,1,1,1,1];
        case 2
            oppCards = [1,1,lcard(1),lcard(2),1 ; 1,1,1,1,1];
        case 3
            oppCards = [1,lcard(1),lcard(2),lcard(3),1 ; 1,1,1,1,1];
        case 4
            oppCards = [1,lcard(1),lcard(2),lcard(3),lcard(4) ; 1,1,1,1,1];
        case 5
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5) ; 1,1,1,1,1];
        case 6
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5); ...
                lcard(6),1,1,1,1];
        case 7
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5); ...
                lcard(6),lcard(7),1,1,1];
        case 8
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5); ...
                lcard(6),lcard(7),lcard(8),1,1];
        case 9
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5); ...
                lcard(6),lcard(7),lcard(8),lcard(9),1];
        otherwise
            oppCards = [lcard(1),lcard(2),lcard(3),lcard(4),lcard(5); ...
                lcard(6),lcard(7),lcard(8),lcard(9),lcard(10)];
    end
    
    youCards = [];
    switch cardPos(1)
        case 1
            youCards = [1,1,card(1),1,1 ; 1,1,1,1,1];
        case 2
            youCards = [1,card(1),card(2),1,1 ; 1,1,1,1,1];
        case 3
            youCards = [1,card(1),card(2),card(3),1 ; 1,1,1,1,1];
        case 4
            youCards = [1,card(1),card(2),card(3),card(4) ; 1,1,1,1,1];
        case 5
            youCards = [card(1),card(2),card(3),card(4),card(5) ; 1,1,1,1,1];
        case 6
            youCards = [card(1),card(2),card(3),card(4),card(5); ...
                card(6),1,1,1,1];
        case 7
            youCards = [card(1),card(2),card(3),card(4),card(5); ...
                card(6),card(7),1,1,1];
        case 8
            youCards = [card(1),card(2),card(3),card(4),card(5); ...
                card(6),card(7),card(8),1,1];
        case 9
            youCards = [card(1),card(2),card(3),card(4),card(5); ...
                card(6),card(7),card(8),card(9),1];
        otherwise
            youCards = [card(1),card(2),card(3),card(4),card(5); ...
                card(6),card(7),card(8),card(9),card(10)];
    end
    
    drawScene(luigi,[l_deal;s],[skip;oppCards;youCards;score,message]);
    
    pause(.75);
    
    drawScene(luigi,[l;s],[skip;oppCards;youCards;score,message]);
end

end