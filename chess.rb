require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'
require_relative 'lib/helper.rb'

#set up board
c = Board.new
c.set_up_board
c.display
#make move
  #ask what piece you want to move
puts "White to move."
puts "Select a piece:"
choice = gets.chomp.to_sym
selected_piece = c.pieces.find { |piece| piece.position == choice }

    #check if that is a valid square
    #check if there is a piece there
  #select that piece
  #get possible moves for that piece
  #ask where you want to move to
  #see if that is in the list of possible moves
  #make the move!
  #check if you have captured someone
    #if so, remove that object from the board
  #check if you have promoted
  #check if you have delivered checkmate
    #if so, end the game
  #check if you have delivered check
  #check for stalemate
    #if so, end the game
  #switch to other player's turn






puts "Where do you want it to go?"
destination = gets.chomp.to_sym
c.squares[choice] = " "
c.squares[destination] = selected_piece.char
selected_piece.position = destination
c.display

selected_piece.get_possible_moves
puts selected_piece.possible_moves.inspect
