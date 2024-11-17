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
                    obj.solution = [obj.inbox,obj.inbox,obj.inbox];
                case 4
                case 5
                case 6
                case 7
                case 8
                case 9
                    obj.solution = obj.inbox;
            end
        end
    end
end