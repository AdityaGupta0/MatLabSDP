%%
function gamble = gambleAmount(money,score)

    global luigi;

    valid = false;

    txt = {'How much do you want to gamble?', ['You have $', num2str(money)]};

    t = text(25,725,txt, FontSize=14);

    scoreTxt = {['Player Wins: ',num2str(score(1))],['Dealer Wins: ',num2str(score(2))] ...
        ,['Ties: ',num2str(score(3))]};

    scoreDisplay = text(25,1200,scoreTxt,FontSize=14);

    amount = '';

    amountO = [];

    letMeOut=false;

    while ~valid

        gambleSet = [];
        gamble = 0;
        digit = 1;
        enter = false;

        back = false;

        while ~enter
            key = getKeyboardInput(luigi);
            if strcmp(key,'1')
                gambleSet(digit) = 1;
            elseif strcmp(key,'2')
                gambleSet(digit) = 2;
            elseif strcmp(key,'3')
                gambleSet(digit) = 3;
            elseif strcmp(key,'4')
                gambleSet(digit) = 4;
            elseif strcmp(key,'5')
                gambleSet(digit) = 5;
            elseif strcmp(key,'6')
                gambleSet(digit) = 6;
            elseif strcmp(key,'7')
                gambleSet(digit) = 7;
            elseif strcmp(key,'8')
                gambleSet(digit) = 8;
            elseif strcmp(key,'9')
                gambleSet(digit) = 9;
            elseif strcmp(key,'0')
                gambleSet(digit) = 0;
            elseif strcmp(key,'return')
                enter = true;
                digit = digit - 2;
            elseif strcmp(key,'backspace') && digit ~=1
                digit = digit - 2;
                gambleSet(digit+1) = [];
            elseif strcmp(key, 'escape')
                letMeOut = true;
                break;
            else
                digit = digit - 1;
            end
            
            delete(amountO)
            amountO = [];
            amount = num2str(gambleSet);
            amountO = text(25,825,amount, FontSize=14);

            digit = digit + 1;

        end

        if ~letMeOut

            for i=digit:-1:1
                gamble = gamble + gambleSet(i) * 10^(digit-i);
            end
    
            if gamble <= money
                valid = true;
            else
                delete(amountO)
                amountO = [];
                amount = 'Invalid';
                amountO = text(25,825,amount, FontSize=14);
            end
        else
            gamble = -1;
            break;
        end
    end
    delete(t)
    delete(amountO)
    delete(scoreDisplay)
    clear amount
end