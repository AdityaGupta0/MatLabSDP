function [smartChoice] = dealChoice(gamble)
    global total;
    global deck;
    % tells the opponent to hit or stand
    distanceFrom21 = 21-total(2);
    goodCards = 0;    
    hit = false;
    smartChoice = false;
    for i = 1 : deck
    for i = 1 : deck.numel()
        if deck[] <= distanceFrom21
            goodCards = goodCards + 1;
        end
    end   

    probability = goodCards / deck.numel() * 100;

    if probability >= 50
        hit = true;
    else
        hit = false;
    end

   
    if gamble > 0 && gamble < 100
        smartChoice = randomDecision(15) && hit;            
    elseif gamble >= 100 && gamble < 300
        smartChoice = randomDecision(30) && hit;  
    elseif gamble >= 300 && gamble < 800
        smartChoice = randomDecision(45) && hit;
    elseif gamble >= 800 && gamble < 2000
        smartChoice = randomDecision(60) && hit;
    elseif gamble >= 2000 && gamble < 5000
        smartChoice = randomDecision(70) && hit;
    elseif gamble >= 5000 && gamble < 10000
        smartChoice = randomDecision(80) && hit;
    elseif gamble >= 10000 && gamble < 30000
        smartChoice = randomDecision(90) && hit;
    elseif gamble >= 30000
        smartChoice = randomDecision(100) && hit;
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