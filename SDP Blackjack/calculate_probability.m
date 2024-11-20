function win_prob = calculate_probability(player_total, dealer_total)
    % Simplified win probability calculation
    if player_total > 21
        win_prob = 0; % Player busts
    elseif dealer_upcard >= 7
        % Dealer has a strong upcard (7–A)
        win_prob = max(0, 1 - (dealer_upcard - 6) * 0.1); % Higher dealer card = lower chance
    else
        % Dealer has a weak upcard (2–6)
        win_prob = min(1, 0.5 + (21 - player_total) * 0.03); % Lower player total = lower chance
    end
end