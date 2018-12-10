require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'
require_relative 'lib/helper.rb'

c = Board.new
c.set_up_board
c.display

puts "White to move."
puts "Select a piece:"
choice = gets.chomp.to_sym
selected_piece = c.pieces.find { |piece| piece.position == choice }

puts "Where do you want it to go?"
destination = gets.chomp.to_sym
c.squares[choice] = " "
c.squares[destination] = selected_piece.char
c.display

puts selected_piece.possible_moves
