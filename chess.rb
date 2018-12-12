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
  opp_color = 'black' if current_color == 'white'
  opp_color = 'white' if current_color == 'black'

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

  #check if there is a piece object at selected position
  until selected_piece != nil
    puts "No piece at that position. Please select again:"
    choice = gets.chomp.to_sym
    selected_piece = b.pieces.find { |piece| piece.position == choice }
  end

  #check if it is opponent's piece
  until current_color == selected_piece.color
    puts "You have selected your opponent's piece. Please select again:"
    choice = gets.chomp.to_sym
    selected_piece = b.pieces.find { |piece| piece.position == choice }
  end

  #ask where you want to move to
  puts "Where do you want it to go?"
  selected_piece.get_possible_moves(b)
  destination = gets.chomp.to_sym

  #see if that is in the list of possible moves
  until selected_piece.possible_moves.include?([selected_piece.position, destination])
    puts "Not a valid move. Please select again:"
    destination = gets.chomp.to_sym
  end

  #see if that move would put you in check
  until moves_into_check?(b,current_color,choice,destination) == false
    puts "This move would put you in check. Please select again:"
    destination = gets.chomp.to_sym
  end

  #check if you have going to capture someone. if so, remove that object from the board
  if occupied_by_opponent?(b, destination, current_color) == true && occupied_by_king?(b, destination, current_color) == false
    opponent_piece = b.pieces.find { |piece| piece.position == destination }
    opponent_piece.position = nil
    opponent_piece.char = " "
    opponent_piece.color = nil
    b.pieces.delete(opponent_piece)
  end

  #make the move! includes castling
  if choice == :e1 && destination == :g1
    selected_piece.castle_short(b, 'white')
  elsif choice == :e1 && destination == :c1
    selected_piece.castle_long(b, 'white')
  elsif choice == :e8 && destination == :g8
    selected_piece.castle_short(b, 'black')
  elsif choice == :e1 && destination == :c8
    selected_piece.castle_long(b, 'black')
  else
    b.squares[choice] = " "
    puts b.squares[choice]
    b.squares[destination] = selected_piece.char
    selected_piece.position = destination
    selected_piece.moves += 1
  end

  #promote any pawns on the 1st or 8th rank (autopromote to queen, might add other options later)
  b.promote_pawns

  #display board, must display after promotion in case of the character change
  b.display

  #check for checkmate
  if checkmated?(b, opp_color)
    puts "Checkmate! #{current_color.capitalize} wins."
    game_on = false
    break
  end

  #check for stalemate
  if checkmated?(b, opp_color)
    puts "Stalemate! It's a draw."
    game_on = false
    break
  end

  #check for regular old check
  if in_check?(b, opp_color) == true
    b.check = true
    puts "Check!"
  end

  #switch to other player's turn
  if current_color == 'white'
    current_color = 'black'
  else current_color = 'white'
  end

end

puts "Game over."
