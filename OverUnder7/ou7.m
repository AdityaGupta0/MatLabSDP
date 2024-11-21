%Create a scene by using simpleGameEngine
dice_scene = simpleGameEngine('retro_simple_dice.png', 16, 16, 8, [167, 177, 183]);
blank_sprite = 10;
initial_chips = 50;

function chips = startQuiz(dice_scene, blank_sprite, initial_chips)
    questions = {"Electrical engineers design circuits. True or False?", 't';
        "Mechanical engineers study forces and motion. True or False?", 't';
        "Civil engineers work with coding software. True or False?", 'f';
        "Chemical engineers build roads and bridges. True or False?", 'f';
        "Software engineers develop algorithms. True or False?", 't';
        "The Ohio State University College of Engineering offers 15 majors. True or False?", 't';
        "There are over 100 student organizations with the College of Engineering. True or False?", 't';
        "Undergraduate students are unable to participate in research. True or False?", 'f';
        "Scalars are 2 dimensional datasets that can be used in problems and computations. True or False?", 'f';
        "In order to suppress command window output, you end a line with a semicolon. True or False?", 't';
        "An Arduino is a small open-source piece of hardware considered to be a microcontroller that works as a tiny computer to carry out code and perform a function. True or False?", 't';
        "Use a while loop when you know how many iterations you want to run, and a for loop when you do not know how many iterations. True or False?", 'f';
        "DR PIE consists of Define, Represent, Plan, Implement, and Evaluate", 't';
        
        };

    chips = initial_chips; %Start with 50 initial chips before answering questions
    rand_order = randperm(size(questions,1)); %Make the order of questions random

    for i = rand_order
        question = questions{i, 1};
        correct_answer = questions{i,2};

        %Display the question
        drawScene(dice_scene, ones(4,4) * blank_sprite); % blank scene
        delete(findall(gcf, 'Type', 'text')); %delete previous text
        text(0.5,0.6, [question, '(Answer: T/F)'], 'FontSize', 14, 'Color', 'blue', 'HorizontalAlignment', 'center', 'Units', 'normalized');
        text(0.5,0.2, ['Chips:', num2str(chips)], 'FontSize', 12, 'Color', 'green', 'HorizontalAlignment', 'center', 'Units', 'normalized');
        
        %Prompt player to input a key to start the game
        key = getKeyboardInput(dice_scene);

        if strcmpi(key, correct_answer)
            chips = chips + 10; % add 10 chips for every correct answer
        else
            %If answer is incorrect
            drawScene(dice_scene, ones(4,4) * blank_sprite);
            delete(findall(gcf, 'Type', 'text'));
            text(0.5, 0.5, 'Wrong Answer! Starting the game...', 'FontSize', 14, 'Color', 'red', 'HorizontalAlignment', 'center', 'Units','normalized');
            pause(2);
            break; %exit the quiz when player chooses an incorrect answer
        end
    end
end

%start screen
function startGame(dice_scene)
    drawScene(dice_scene, ones(4, 4) * 10); %blank scene
    delete(findall(gcf, 'Type', 'text'));
    text(0.5, 0.5, 'Welcome to Over/Under Seven! Press any key to start.','FontSize', 16, 'Color', 'blue', 'HorizontalAlignment', 'center', 'Units', 'normalized');
    getKeyboardInput(dice_scene); %wait for player to press a
end

%main game loop
while true
    startGame(dice_scene) %start screen
    chips = startQuiz(dice_scene, blank_sprite, initial_chips); %start quiz to earn chips
    
    while chips > 0
        %display the current amount of chips and the betting prompt
        drawScene(dice_scene, ones(4, 4) * blank_sprite); %blank scene
        delete(findall(gcf, 'Type', 'text'));
        text(0.5, 0.1, ['Your chips: ', num2str(chips)], 'FontSize', 14, 'Color', 'green', 'HorizontalAlignment', 'center', 'Units', 'normalized');
        text(0.5, 0.5, 'Guess Over (O), Under (U), or Exactly Seven (E):', 'FontSize', 14, 'Color', 'blue', 'HorizontalAlignment', ' center', 'Units', 'normalized');

        %Get the player's bet
        player_choice = getKeyboardInput(dice_scene);

        %Roll the dice
        dice_vals = randi(6, 1, 2); %generate 2 random dice values
        dice_sum = sum(dice_vals);

        %display the dice roll
        dice_scene_matrix = ones(4,4) * blank_sprite; %base scene
        dice_scene_matrix(2,2) = dice_vals(1); %first die
        dice_scene_matrix(2,3) = dice_vals(2); %second die
        drawScene(dice_scene, dice_scene_matrix);

        delete(findall(gcf, 'Type', 'text'));
        text(0.5, 0.3, ['You rolled: ', num2str(dice_vals(1)), ' + ', num2str(dice_vals(2)), ' = ', num2str(dice_sum)], 'FontSize', 14, 'Color', 'blue', 'HorizontalAlignment', 'center', 'Units', 'normalized');

        %determine the outcome
        if (player_choice == 'o' && dice_sum > 7) || ...
           (player_choice == 'u' && dice_sum < 7) || ...
           (player_choice == 'e' && dice_sum == 7)
            chips = chips + 10; %win 10 chips
            text(0.5, 0.4, 'You win! +10 chips.', 'FontSize', 14, 'Color', 'green', 'HorizontalAlignment', 'center', 'Units', 'normalized');
        else
            chips = chips - 10; %lose 10 chips
            text(0.5, 0.4, 'You lose! -10 chips.', 'FontSize', 14, 'Color', 'red', 'HorizontalAlignment', 'center', 'Units', 'normalized');
        end

        %pause in order to display the result
        pause(2.5);

        %check if the player is out of chips
        if chips <= 0
            drawScene(dice_scene, ones(4,4) * blank_sprite); %blank scene
            delete(findall(gcf, 'Type', 'text'));
            text(0.5, 0.5, 'Game over! Out of chips.', 'FontSize', 16, 'Color', 'red', 'HorizontalAlignment', 'center', 'Units', 'normalized');
            pause(2);
            break
        end
    end
end
