function [choice] = dealChoice(gamble)
    global total;
    
    while true
        if total(2) <= total(1) && ~(total(2)>18 && total(2)==total(1))
            drawCard(1,2)
            graphicOutput(2)
        else
            break
        end
    end
end