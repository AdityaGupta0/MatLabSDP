function [smartChoice] = dealChoice(gamble)
    global total;
    global deck;
    global cardsLeft;
    % tells the opponent to hit or stand
    % 9, K
    % Q, 10
    goodCards = 0;    
    hit = false;
    smartChoice = false;
    distanceFrom21 = 21-total(2);
    if distanceFrom21 > 10 && total(1) > total(2) && gamble >= 100
        smartChoice = true;
    elseif total(1) > total(2)     
        %for i = 1 : deck
        %[r,c] = size(deck);
        if distanceFrom21 > 10
            distanceFrom21 = distanceFrom21 - 10;
        end
        for i = 1 : 4
            for j = 1 : distanceFrom21-1
                if deck(j,i)
                    goodCards = goodCards + 1;
                end
            end
            if deck(13,i)
                goodCards = goodCards + 1;
            end
        end
    
        %{
    >>>>>>> Stashed changes
        for i = 1 : deck.numel()
            if deck[] <= distanceFrom21
                goodCards = goodCards + 1;
            end
        end  
        %}
    
        probability = goodCards / cardsLeft * 100;
        
        if probability >= 50 || total(1) > total(2)
            hit = true;
        else
            hit = false;
        end
    
       
        if gamble > 0 && gamble < 10
            smartChoice = randomDecision(50) && hit;            
        elseif gamble >= 10 && gamble < 30
            smartChoice = randomDecision(60) && hit;  
        elseif gamble >= 30 && gamble < 80
            smartChoice = randomDecision(70) && hit;
        elseif gamble >= 80 && gamble < 150
            smartChoice = randomDecision(80) && hit;
        elseif gamble >= 150 && gamble < 250
            smartChoice = randomDecision(90) && hit;
        elseif gamble >= 250 && gamble < 400
            smartChoice = randomDecision(100) && hit;
        elseif gamble >= 400 && gamble < 500
            smartChoice = randomDecision(100) && hit;
        elseif gamble >= 500
            smartChoice = randomDecision(100) && hit;
        end
    else
        smartChoice = false;
    end    
end

    %{
    while true
        if total(2) <= total(1) && ~(total(2)>18 && total(2)==total(1))
            drawCard(1,2)
            graphicOutput(2)
        else
            break
        end
    end
end
    %}