function decision = decisions_AI(player_total,dealer_total);
    
    decisions = [2:20,1:10]; 
  
    decisions(2:11,:) = "H";
    decisions(12,2:3) = "H"; 
    decisions(12,4:6) = "S"; 
    decisions(12,7:10) = "H"; 
    decisions(13,1:6) = "S";
    decisions(13,7:10) = "H";
    decisions(14,1:6) = "S"; 
    decisions(14,7:10) = "H";
    decisions(15,1:6) = "S";
    decisions(15,7:10) = "H"; 
    decisions(16,1:6) = "S"; 
    decisions(16,7:10) = "H"; 
    decisions(17:20,:) = "S"; 

    decision = decisions(player_total,dealer_total);
end
