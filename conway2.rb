#!/bin/ruby

# Head ends here

WHITE, BLACK = 'w', 'b'

def nextMove(player,board)
  
end

# Tail starts here
player = gets.chomp
board = Array.new(29)

(0...29).each do |i|
    board[i] = gets
end

a,b = nextMove(player,board)
puts a.to_s+" "+b.to_s