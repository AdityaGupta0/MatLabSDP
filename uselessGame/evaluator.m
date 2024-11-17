classdef evaluator < handle
    properties
        inbox;
        outbox;
        level;
        outboxNum;
        solution;
    end
    methods 
        function obj = evaluator(level,initialLevelArray)
            obj.level = level;
            for i=1:7
                if initialLevelArray(i+2,2) ~= 101
                    obj.inbox(i) = interpreter.sprite2Number(initialLevelArray(i+2,2));
                end
            end
            obj.outboxNum = 1;
            solve(obj);
        end

        function statusCode = evalutate(obj,newLevelArray)
            if interpreter.sprite2Number(newLevelArray(3,6)) == obj.solution(obj.outboxNum) %checks if the latst output value lines up with solution
                fprintf('Correct\n');
                statusCode = 0; %if the output value is correct return nominal status code
                obj.outboxNum = obj.outboxNum + 1;
            else
                txt = sprintf('Level Failed: outboxed %d when %d was expected',interpreter.sprite2Number(newLevelArray(3,6)),obj.solution(obj.outboxNum));
                fprintf(txt);
                displayMsg(txt);
                statusCode = -1; %if the output value is incorrect return stop status code
            end
        end

        function correct = finalEval(obj)
            if (obj.outboxNum-1) == length(obj.solution) %checks if the number of outputs is correct. outboxnum is offset bc it increments after the last output
                correct = true;
                fprintf('You have completed the level\n');
                displayMsg('You finished the level!!');
            else
                correct = false;
                fprintf('Your outputs were correct but did not complete the level.\n');
                displayMsg('Level Incomplete.');
            end
        end

        function solve(obj)
            switch obj.level
                case 1
                    obj.solution = obj.inbox;
                case 2
                    obj.solution = obj.inbox;
                case 3
                    obj.solution = [obj.inbox,obj.inbox];
                case 4 %reverse each group of two numbers
                    obj.solution = [obj.inbox(2),obj.inbox(1),obj.inbox(4),obj.inbox(3),obj.inbox(6),obj.inbox(5)];
                case 5 %adds each group of two numbers
                    obj.solution = [(obj.inbox(1)+obj.inbox(2)),(obj.inbox(3)+obj.inbox(4)),(obj.inbox(5)+obj.inbox(6))];
                case 6 %outputs all values that arent zero
                    obj.solution = obj.inbox(obj.inbox~=0);
                case 7 %zero if negative, one if positive
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
                case 9
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
                    for i=1:length(obj.inbox)
                        if obj.inbox(i) < 0
                            for j=0:obj.inbox(i)
                                obj.solution = obj.inbox(i)+j;
                            end
                        else
                            for j=0:obj.inbox(i)
                                obj.solution = obj.inbox(i)-j;
                            end
                        end
                    end
                case 12 %free play
                    %obj.solution = obj.outbox;
            end
        end
    end
end