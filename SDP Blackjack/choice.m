%%
function hit = choice()

    global luigi;
    
    % get keyboard input
    key = getKeyboardInput(luigi);
    % if choice is h, enter, or space
    if strcmp(key,'h') || strcmp(key,'return') || strcmp(key,'space')
        % return true
        hit = true;
    else
        % else return false
        hit = false;
    end
end