classdef evaluator < handle
    properties
        inbox;
        outbox;
        level;
        lineNum;
    end
    methods 
        function obj = evaluator(level,initialLevelArray)
            obj.level = level;
            for i=1:7
                if initialLevelArray(i+2,2) == 101
                    obj.inbox(i) = 0;
                else
                    obj.inbox(i) = interpreter.sprite2Number(initialLevelArray(i+2,2));
                end
            end
        end

        function evalutate(obj,finalLevelArray)
            for i=1:7
                if finalLevelArray(i+2,6) == 101
                    obj.outbox(i) = 0;
                else
                    obj.outbox(i) = interpreter.sprite2Number(finalLevelArray(i+2,6));
                end
            end
            solution = solve(obj);
            if obj.outbox == solution
                fprintf('Correct\n');
            else
                fprintf('Your solution produced %d when %d was expected\n',obj.inbox,obj.outbox);
            end

        end

        function solution = solve(obj)
            switch obj.level
                case 1
                   solution = flip(obj.inbox);
                case 2
                case 3
                case 4
                case 5
                case 6
                case 7
                case 8
                case 9
                    solution = flip(obj.inbox);
            end
        end
    end
end