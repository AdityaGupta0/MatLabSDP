%%
function loop = exitLoop()
  
global luigi;

    key = getKeyboardInput(luigi);
    if strcmp(key,'n') || strcmp(key,'escape') || strcmp(key,'backspace')
        loop = false;
    else
        loop = true;
    end
end