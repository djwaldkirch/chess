require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'
require_relative 'lib/helper.rb'


current_color = 'white'
game_on = true
#set up board
b = Board.new
b.set_up_board
b.display
while game_on == true

  #make move
  #ask what piece you want to move

  puts "#{current_color.capitalize} to move."
  puts "Select a piece:"
  choice = gets.chomp.to_sym
  selected_piece = b.pieces.find { |piece| piece.position == choice }
  selected_piece.possible_moves = []
  #check if the square is valid and there is a piece there
  until valid_square?(choice) == true
    puts "Not a valid square. Please select again:"
    choice = gets.chomp.to_sym
    selected_piece = b.pieces.find { |piece| piece.position == choice }
  end

  until selected_piece != nil
    puts "No piece at that position. Please select again:"
    choice = gets.chomp.to_sym
    selected_piece = b.pieces.find { |piece| piece.position == choice }
  end

  until current_color == selected_piece.color
    puts "You have selected your opponent's piece. Please select again:"
    choice = gets.chomp.to_sym
    selected_piece = b.pieces.find { |piece| piece.position == choice }
  end

  #ask where you want to move to
  puts "Where do you want it to go?"
  selected_piece.get_possible_moves(b)
  puts selected_piece.possible_moves.inspect
  destination = gets.chomp.to_sym

  #see if that is in the list of possible moves
  until selected_piece.possible_moves.include?(destination)
    puts "Not a valid move. Please select again:"
    destination = gets.chomp.to_sym
  end

  #check if you have going to capture someone
  if occupied_by_opponent?(b, destination, current_color) == true && occupied_by_king?(b, destination, current_color) == false
    opponent_piece = b.pieces.find { |piece| piece.position == destination }
    opponent_piece.position = nil
    opponent_piece.char = " "
    opponent_piece.color = nil
    b.pieces.delete(opponent_piece)
  end
    #if so, remove that object from the board

  #make the move!
  b.squares[choice] = " "
  puts b.squares[choice]
  b.squares[destination] = selected_piece.char
  selected_piece.position = destination
  b.display


  #check if you have promoted
  #check if you have delivered checkmate
    #if so, end the game
  #check if you have delivered check
  #check for stalemate
    #if so, end the game
  #switch to other player's turn
  if current_color == 'white'
    current_color = 'black'
  else current_color = 'white'
  end

end
