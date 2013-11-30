#!/bin/ruby

def calculate_bid(player, pos, first_moves, second_moves)
    my_moves, their_moves = first_moves, second_moves if player == 1
    their_moves, my_moves = first_moves, second_moves if player == 2

    my_wallet, their_wallet, my_draw_advantage = my_moves.zip(their_moves).reduce([100,100,player==1]) do |(my_pocket, their_pocket, draw_advantage), (my_bid, their_bid)|
        if my_bid > their_bid
            [my_pocket - my_bid, their_pocket, draw_advantage]
        elsif their_bid > my_bid
            [my_pocket, their_pocket - their_bid, draw_advantage]
        elsif draw_advantage
            [my_pocket - my_bid, their_pocket, !draw_advantage]
        elsif !draw_advantage
            [my_pocket, their_pocket - their_bid, !draw_advantage]
        end
    end

    steps_to_win = if player == 1 then pos else 10 - pos end
    
    # clamps bid into a valid range
    bid = ->(b) do
        if my_wallet > 0
            [[1,b].max, my_wallet].min
        else 
            0
        end
    end

    beat_this = ->(amount) do
        bid[ my_draw_advantage ? amount : amount + 1 ]
    end
    
    # handle some obvious situations
    return bid[1]         if their_wallet.zero?
    return bid[0]         if my_wallet.zero?
    return bid[my_wallet] if steps_to_win == 1
    
    if steps_to_win == 9
        # if opponent about to win, go for desperation!
        beat_this[ their_wallet ]
    elsif their_moves.size > 1 && their_moves[-1] == their_moves[-2]
        # opponent repeated a move twice: beat it
        beat_this[ their_moves.last ]
    elsif their_wallet * 5 / 4 >= my_wallet
        # let them blow their cash and wear them down
        # (but sneak in some cheap wins if we can)
        bid[ my_wallet / (steps_to_win * 3 / 2) ]
    else 
        # we have the advantage: use a simple strategy 
        # of trying to beat their weighted average bid...
        weights = 1..their_moves.size
        w_avg = their_moves.zip(weights).reduce(0) {|sum,pair| sum+pair[0]*pair[1]} / weights.reduce(&:+)
        beat_this[ [w_avg, their_wallet, my_wallet - steps_to_win].min ]
    end
end

#gets the id of the player
player = gets.to_i

scotch_pos = gets.to_i         #current position of the scotch

first_moves = gets.split.map {|num| num.to_i}
second_moves = gets.split.map {|num| num.to_i}

bid = calculate_bid(player,scotch_pos,first_moves,second_moves)
puts bid
