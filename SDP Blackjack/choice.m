%%
function hit = choice()

    global luigi;

    key = getKeyboardInput(luigi);
    if strcmp(key,'h') || strcmp(key,'return') || strcmp(key,'space')
        hit = true;
    else
        hit = false;
    end
end