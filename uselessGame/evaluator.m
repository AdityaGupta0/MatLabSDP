classdef evaluator < handle %class for validating the individual line by line outputs and overall completion of levels
    properties
        inbox;
        outbox;
        level;
        outboxNum;
        solution;
    end
    methods 
        function obj = evaluator(level,initialLevelArray) %constructor
            obj.level = level;
            for i=1:7 %retreives inputs from the level array
                if initialLevelArray(i+2,2) ~= 101
                    obj.inbox(i) = interpreter.sprite2Number(initialLevelArray(i+2,2));
                end
            end
            obj.outboxNum = 1; %initializes a counter
            solve(obj);
        end
        function statusCode = evalutate(obj,newLevelArray) %evaluates the output of the program line by line
            if obj.level == 13 %if the level is free play
                statusCode = 0; %return nominal status code
            elseif interpreter.sprite2Number(newLevelArray(3,6)) == obj.solution(obj.outboxNum) %checks if the latst output value lines up with solution
                fprintf('Correct\n');
                statusCode = 0; %if the output value is correct return nominal status code
                obj.outboxNum = obj.outboxNum + 1;
            else
                txt = sprintf('Level Failed: outboxed %d when %d was expected',interpreter.sprite2Number(newLevelArray(3,6)),obj.solution(obj.outboxNum));
                fprintf(txt);
                displayMsg(txt); %displays the error message to the user
                statusCode = -1; %if the output value is incorrect return stop status code
            end
        end

        function correct = finalEval(obj,editorWindowArray,stepCount)
            if obj.level == 13 %if the level is free play
                correct = true; %return true
                fprintf('Free Play Program Complete\n');
                displayMsg('Program Complete!');
            elseif (obj.outboxNum-1) == length(obj.solution) %checks if the number of outputs is correct. outboxnum is offset b/c it increments after the last output
                correct = true;
                fprintf('You have completed the level\n');
                count = 0;
                for i=2:1:15 %counts the number of blocks used
                    if editorWindowArray(i,9) ~= 101
                        count = count + 1;
                    end
                end
                displayMsg(sprintf("Level complete! Your used %d blocks, ideal is %d. You took %d steps, ideal is %d.",count,evaluator.getBestSize(obj.level),stepCount,evaluator.getBestSteps(obj.level)));
            else
                correct = false; %if the number of outputs is incorrect return false
                fprintf('Your outputs were correct but did not complete the level.\n');
                displayMsg('Level Incomplete.');
            end

        end

        function solve(obj) %creates solution based on level using inbox
            switch obj.level
                case 1
                    obj.solution = obj.inbox;
                case 2
                    obj.solution = obj.inbox;
                case 3 %outputs the first number twice
                    obj.solution = [obj.inbox,obj.inbox];
                case 4 %reverse each group of two numbers
                    obj.solution = [obj.inbox(2),obj.inbox(1),obj.inbox(4),obj.inbox(3),obj.inbox(6),obj.inbox(5)];
                case 5 %adds each group of two numbers
                    obj.solution = [(obj.inbox(1)+obj.inbox(2)),(obj.inbox(3)+obj.inbox(4)),(obj.inbox(5)+obj.inbox(6))];
                case 6 %outputs all values that arent zero
                    obj.solution = obj.inbox(obj.inbox~=0);
                case 7 %outputs zero if negative, one if positive
                    for i=1:5
                        if obj.inbox(i+2) < 0
                            obj.solution(i) = 0;
                        else
                            obj.solution(i) = 1;
                        end
                    end
                case 8 %subtracts each group of two numbers both ways
                    for i=1:2:6
                        obj.solution(i) = obj.inbox(i+1)-obj.inbox(i);
                        obj.solution(i+1) = obj.inbox(i)-obj.inbox(i+1);
                    end
                case 9 %outputs the larger of each group of two numbers
                    a = 1; %increments by 1 for outbox
                    b = 1; %increments by 2 for inbox
                    while a<4
                        if obj.inbox(b)>obj.inbox(b+1)
                            obj.solution(a) = obj.inbox(b);
                            
                        else
                            obj.solution(a) = obj.inbox(b+1);
                        end
                        a = a+1;
                        b = b+2;
                    end
                case 10 %absolute value
                    obj.solution = abs(obj.inbox);
                case 11 %counts down/up for each value in the array
                    k=1;
                    for i=1:length(obj.inbox)
                        if obj.inbox(i) < 0
                            for j=0:-obj.inbox(i) %negates inbox value so that it counts up
                                obj.solution(k) = obj.inbox(i)+j;
                                k=k+1;
                            end
                        elseif obj.inbox(i) == 0 %edge case of zero
                            obj.solution(k) = 0;
                            k=k+1;
                        else
                            for j=0:obj.inbox(i) %counts down to zero 
                                obj.solution(k) = obj.inbox(i)-j;
                                k=k+1;
                            end
                        end
                    end
                case 12 %multiplies every two numbers
                    obj.solution = [obj.inbox(1)*obj.inbox(2),obj.inbox(3)*obj.inbox(4),obj.inbox(5)*obj.inbox(6)];
                case 13 %free play
                    obj.solution = [];
            end
        end
    end
    methods (Static)
        function bestSize = getBestSize(level) %returns the optimal program size in terms of number of lines
            sizes =  [3,3,5,7,6,5,13,10,11,8,9,13];
            levels = [1,2,3,4,5,6,7,8,9,10,11,12];
            sizeMap = containers.Map(levels,sizes); %hashmap for optimal program sizes for each level
            bestSize = sizeMap(level);
        end
        function bestSteps = getBestSteps(level) %returns the optimal number of steps for the program to do
            steps = [4,14,5,21,18,31,34,30,29,38,82,65];
            levels = [1,2,3,4,5,6,7,8,9,10,11,12];
            stepMap = containers.Map(levels,steps); %hashmap for optimal number of steps for each level
            bestSteps = stepMap(level);
        end
    end
end