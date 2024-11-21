function wrappedText = wrapText(text, lineLength)
    words = split(text);
    line = ""; 
    wrappedText = "";
    for i = 1:length(words)
        if strlength(line) + strlength(words{i}) + 1 <= lineLength
            line = line + " " + words{i}; 
        else
            wrappedText = wrappedText + line + newline; 
            line = words{i}; 
        end
    end
    wrappedText = wrappedText + line; 
end