%%
% has 2 parameters
% money - how much money the player has TOTAL
% score - the current score between wins, losses, and ties
function gamble = gambleAmount(money,score)

    global luigi;

    valid = false;

    % text displaying to screen for prompting user, and reset & exit keys
    txt = {'How much do you want to gamble?', ['You have $', num2str(money)], '(r to reset, esc to exit)'};

    t = text(25,725,txt, FontSize=14);

    % score display
    scoreTxt = {['Player Wins: ',num2str(score(1))],['Dealer Wins: ',num2str(score(2))] ...
        ,['Ties: ',num2str(score(3))]};

    % in-game controls display
    controls = text(25,1085, {'HIT - h / enter / space','STAND - s / any key'},FontSize=14);

    scoreDisplay = text(25,1200,scoreTxt,FontSize=14);

    amount = '';

    amountO = [];

    letMeOut=0;


    message = funFact();
    fact = text(25,880,message,FontSize=14);

    % loop to check if gamble input is valid
    while ~valid

        gambleSet = [];
        gamble = 0;
        digit = 1;
        enter = false;

        back = false;

        % while loop to keep getting inputs from keyboard and store
        while ~enter && digit < 17
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
            % if return, then exit loop and go with current numbers
            elseif strcmp(key,'return')
                enter = true;
                digit = digit - 2;
            % if backspace, then delete last one and go back one as well
            elseif strcmp(key,'backspace') && digit ~=1
                digit = digit - 2;
                gambleSet(digit+1) = [];
            % if escape, then exit entire loop and exit program
            elseif strcmp(key, 'escape')
                letMeOut = 1;
                break;
            % if r, then exit and reset money and score
            elseif strcmp(key, 'r')
                letMeOut = 2;
                break;
            else
                digit = digit - 1;
            end
   
            % deleting previous text displayed
            % outputing numbers inputed to the screen
            delete(amountO)
            amountO = [];
            amount = num2str(gambleSet);
            amountO = text(25,820,amount, FontSize=14);

            digit = digit + 1;

        end

        if letMeOut == 0
            
            % if number of inputs goes offscreen, cut it off
            if digit == 17
                delete(amountO)
                amountO = [];
                amount = 'Invalid';
                amountO = text(25,820,amount, FontSize=14);
            else
                % going through each digit given
                for i=digit:-1:1
                    % adding to gamble
                    gamble = gamble + gambleSet(i) * 10^(digit-i);
                end
        
                % if gamble amount is less/equal to money amount, its valid
                if gamble <= money
                    valid = true;
                else
                    % if not then reprompt user again
                    delete(amountO)
                    amountO = [];
                    amount = 'Invalid';
                    amountO = text(25,820,amount, FontSize=14);
                end
            end
        elseif letMeOut == 1
            gamble = -1;
            break;
        elseif letMeOut == 2
            gamble = -2;
            break;
        end
    end
    delete(t)
    delete(amountO)
    delete(scoreDisplay)
    delete(controls)
    delete(fact)
    clear amount
end