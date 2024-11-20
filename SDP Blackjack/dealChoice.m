function [choice] = dealChoice(gamble)
    global total;
    % tells the opponent to hit or stand
    while true
        if gamble > 0 && gamble < 100
        elseif gamble >= 100 && gamble < 300
        elseif gamble >= 300 && gamble < 800
        elseif gamble >= 800 && gamble < 2000
        elseif gamble >= 2000 && gamble < 5000
        elseif gamble >= 5000 && gamble < 10000
        elseif gamble >= 10000 && gamble < 30000
        elseif gamble >= 30000
        end
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