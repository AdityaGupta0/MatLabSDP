
% CHANGE FINAL RESULTS TO ANOTHER FUNCTION
% POSSIBLE SEPERATE FUNCTION FOR OPP WHEN ADDING SMART AI

%% MAIN SCRIPT

clear
clc

% loop for each iteration of the game
% only saving the money and score variables

% main screen to output graphics to
global luigi;
luigi = simpleGameEngine('lets_go_gambling.png',32,32,4);

% creation/initialization of main variables/arrays/matrixes used
global deck;
global numAces;
global total;
global cards;

% set money and score to default values
money = 100;
score = [0,0,0];

loop = true;
while loop
    
    loop = false;
    
    %clc
    
    % deck is the overall deck of undrawn cards, preventing duplicates
    deck = logical(true(13,4));
    % numAces is used to determine the value of aces for both player & opponent
    % when going over 21, setting it to 1 instead.
    numAces = [0,0];
    % total is the total value of the cards, for both player & opponent
    total = [0,0];
    % cards is the matrix that stores what cards both player & opponent have in
    % their hand
    cards = [];
    
    % output menu screen
    graphicOutput(-1)
    
    % get gamble amount
    gamble = gambleAmount(money,score);
    
    if gamble >= 0
    
        % initial drawing of first 2 cards for player
        drawCard(2,1)
        % draw single card for opponet
        drawCard(1,2)
        
        graphicOutput(0)
        
        % if player already has 21, autowin by the boolean bj
        bj = false;
        if total(1) == 21
            bj=true;
        end
                
        bust = false;
        % if the player hasn't 'won' yet, then prompt for choice
        while total(1)<21
            % two choices, hit or stand
            % hit gives another card, and stand keeps your cards
        
            % if player chose 'hit', then draw another player card and output
            % if player typed anything other than 'h' or 'hit' its read as stand
            if choice()
                drawCard(1,1)

                graphicOutput(1)
            else
                break;
            end
            % if player busted (went over 21) on this draw, end the loop and player
            % auto looses
            if total(1) > 21
                bust = true;
                break;
            end
        end
        % ^^^ loop ends when either player busts, gets equal to 21, or stands
        
        % if game isn't immediately over (due to player bust or 21)
        % then draw cards for opponent, but don't output yet

        if bust==false && bj==false
            drawCard(1,2)
            graphicOutput(2)
            while true
                if total(2) <= total(1) && ~(total(2)>18 && total(2)==total(1))
                    drawCard(1,2)
                    graphicOutput(2)
                else
                    break
                end
            end
        end
            
        % output cards
        graphicOutput(3)
        % if player bust or blackjack, then opponent didn't draw cards, so don't
        % output total
        
        % logic to determine final results, output a proper message, and add to the
        % score and money amount
        if bj
            score(1)=score(1)+1;
            money = money + gamble;
        elseif total(1)>21
            score(2)=score(2)+1;
            money = money - gamble;
        elseif total(2)>21
            score(1)=score(1)+1;
            money = money + gamble;
        elseif total(1)>total(2)
            score(1)=score(1)+1;
            money = money + gamble;
        elseif total(2)>total(1)
            score(2)=score(2)+1;
            money = money - gamble;
        else
            score(3)=score(3)+1;
        end
        loop = true;
    
    elseif gamble == -1
        loop = false;
    elseif gamble == -2
        money = 100;
        score = [0,0,0];
        loop = true;
    end

end

close
clear