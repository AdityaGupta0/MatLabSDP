function [status] = randomDecision(percentage)
status = false;
size = randi(100);
if size <= percentage
    status = true;
end