
% CHANGE FINAL RESULTS TO ANOTHER FUNCTION
% POSSIBLE SEPERATE FUNCTION FOR OPP WHEN ADDING SMART AI

%% MAIN SCRIPT

% loop for each iteration of the game
% only saving the money and score variables

global luigi;
luigi = simpleGameEngine('lets_go_gambling.png',32,32,4);

loop = true;
while loop
    
loop = false;

% if money doesn't exist (first loop) then create it
if exist('money',"var") == false
    money = 100;
end

% if score doesn't exist (first loop) then create it
if exist("score","var") ~= true
    score = [0,0,0];
end

%clc

% creation/initialization of main variables/arrays/matrixes used
global deck;
global numAces;
global total;
global cards;
global consecutiveWins;
consecutiveWins = 0;
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

% IGNORE - PREVIOUS CODE FOR GAMBLING AMOUNT
% REPLACED W/ gambleAmount FUNCTION

% prompt user and store value for gambling amount
%fprintf('You have $%d\n',money)
%gamble=input('How much would you like to gamble?\n');
% while loop to check for valid input
%while (gamble<0 || gamble>money)
%    % value can't be negative
%    if gamble<0
%        gamble=input('Can''t gamble negative amount\nHow much would you like to gamble?\n');
    % value CAN be negative, but double checks choice
%    elseif gamble>money
%        choice=input('You don''t have that much money!');
%    end
%end


graphicOutput(-1)

gamble = gambleAmount(money,score);


if gamble ~= -1

%clc

% initial drawing of first 2 cards for player
drawCard(2,1)
%outputCards(1)

% drawing of one card for opponent, and second is "hidden"
% the second isn't really hidden, it doesn't exist yet but gives illusion
drawCard(1,2)
%outputCards(2)

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
    % choice=input('Hit or Stand?\n',"s");

    % if player chose 'hit', then draw another player card and output
    % if player typed anything other than 'h' or 'hit' its read as stand
    %if strcmpi(choice,'h') | strcmpi(choice,'hit')
    if choice()
        %clc
        drawCard(1,1)
        %outputCards(1)

    % also reprint opponents cards for player to see
        %outputCards(2)

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
% eventually add smart AI and logic here, and potentially difficulty settings
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
    
%clc
% output final player cards
%outputCards(1)
% if player blackjack, then output message
%if bj
%    fprintf('Blackjack!\n\n')
%end

% output final opponent cards
%outputCards(2)
graphicOutput(3)
% if player bust or blackjack, then opponent didn't draw cards, so don't
% output total

previousScore = score(1);
% logic to determine final results, output a proper message, and add to the
% score and money amount
if bj
    %fprintf("Player Wins!\n\n")
    score(1)=score(1)+1;
    money = money + gamble;
elseif total(1)>21
    %fprintf('Player Bust\nOpponent Wins.\n\n')
    score(2)=score(2)+1;
    money = money - gamble;
elseif total(2)>21
    %fprintf('Opponent Bust\nPlayer Wins!\n\n')
    score(1)=score(1)+1;
    money = money + gamble;
elseif total(1)>total(2)
    %fprintf('%d > %d\nPlayer Wins!\n\n',total(1),total(2))
    score(1)=score(1)+1;
    money = money + gamble;
elseif total(2)>total(1)
    %fprintf('%d > %d\nOpponent Wins.\n\n',total(2),total(1))
    score(2)=score(2)+1;
    money = money - gamble;
else
    %fprintf("%d = %d\nIt's a tie\n\n",total(1),total(2))
    score(3)=score(3)+1;
end

if score(1) > previousScore
    consecutiveWins = consecutiveWins + 1;
end
% clear out unused variables for this loop
% can't use clear function because still need 'score' and 'money'
clear bust
clear numAces
clear total
clear choice
clear bj
clear cards
clear deck
clear gamble

% output current score & money
%fprintf('Player: %d - Opponent: %d - Ties: %d\n',score(1),score(2),score(3))
%fprintf('You have $%d\n',money)
% if player has money left, repropmt for another iteration
if money>0
    %choice=input('Play again?\n',"s");
    %if strcmpi(choice,'y') | strcmpi(choice,'yes')
    %    clear choice
    %    loop = true;
    %end
    % loop = exitLoop();
    loop = true;
end

else
    loop = false;
end

end

% reminding the player of their loss
t = text(225,850,'L', FontSize=150);
pause(.5);

close

% after player looeses all money or walks away, output final money and
% profit, and score
fprintf('Player: %d - Opponent: %d - Ties: %d\n',score(1),score(2),score(3))
fprintf('\nFinal Money: $%d\nProfit: $%d\n', money,money-100);
clear