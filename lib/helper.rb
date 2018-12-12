WHITE_PIECES = ["\u2654","\u2655","\u2656","\u2657","\u2658","\u2659"]
BLACK_PIECES = ["\u265A","\u265B","\u265C","\u265D","\u265E","\u265F"]

def to_alg(arr)
  #make sure to look at this. if people go off the board ie have a value of -2 it might grab something wrong
  unless (1..8).include?(arr[0]) && (1..8).include?(arr[1])
    return :z9
  else
    letters = ['a','b','c','d','e','f','g','h']
    letter = letters[arr[0]-1]
    return (letter + arr[1].to_s).to_sym
  end
end

def to_coord(sym)
  string = sym.to_s
  string[0] = "1" if string[0] == "a"
  string[0] = "2" if string[0] == "b"
  string[0] = "3" if string[0] == "c"
  string[0] = "4" if string[0] == "d"
  string[0] = "5" if string[0] == "e"
  string[0] = "6" if string[0] == "f"
  string[0] = "7" if string[0] == "g"
  string[0] = "8" if string[0] == "h"
  return [string[0].to_i, string[1].to_i]
end

def occupied_by_me?(board, position, color)
  if color == 'white'
    if WHITE_PIECES.include?(board.squares[position])
      return true
    else
      return false
    end
  elsif color == 'black'
    if BLACK_PIECES.include?(board.squares[position])
      return true
    else
      return false
    end
  else
    return false
  end
end

def occupied_by_opponent?(board, position, color)
  if color == 'black'
    return true if WHITE_PIECES.include?(board.squares[position])
  elsif color == 'white'
    return true if BLACK_PIECES.include?(board.squares[position])
  else
    return false
  end
end

def occupied_by_king?(board, position, color)
  if color == 'white'
    if (board.squares[position]) == "\u265A"
      return true
    else
      return false
    end
  elsif color == 'black'
    if (board.squares[position]) == "\u2654"
      return true
    else
      return false
    end
  end
end

def valid_square?(position)
  string = position.to_s
  if string.length == 2
    if ("a".."h").include?(string[0]) && (1..8).include?(string[1].to_i)
      return true
    else
      return false
    end
  else
    return false
  end
end

#these don't work until i implement the get moves for every piece
def get_all_white_moves(board)
  move_list = []
  white_pieces = board.pieces.find_all {|piece| piece.color == 'white'}
  white_pieces.each do |x|
    x.get_possible_moves(board)
    x.possible_moves.each do |x|
      move_list << x
    end
  end
  return move_list
end

def get_all_black_moves(board)
  move_list = []
  black_pieces = board.pieces.find_all {|piece| piece.color == 'black'}
  black_pieces.each do |x|
    x.get_possible_moves(board)
    x.possible_moves.each do |x|
      move_list << x
    end
  end
  return move_list
end

#this is to turn the check variable on
def gives_check?(board, color)
  if color == 'white'
    #get all of white's possible moves
    moves = get_all_white_moves(board)
    #get the position of the black king
    king = board.pieces.find {|piece| piece.char == "\u265A"}
    return true if moves.include?(king.position)
  else
    moves = get_all_black_moves(board)
    king = board.pieces.find {|piece| piece.char == "\u2654"}
    return true if moves.include?(king.position)
  end
end

#this is to potentially turn it off
def in_check?(board, color)
  if color == 'white'
    #get all of white's possible moves
    moves = get_all_black_moves(board)
    #get the position of the black king
    king = board.pieces.find {|piece| piece.char == "\u2654"}
    moves.each do |move|
      return true if move[1] == king.position
    end
  else
    moves = get_all_white_moves(board)
    king = board.pieces.find {|piece| piece.char == "\u265A"}
    moves.each do |move|
      return true if move[1] == king.position
    end
  end
end

#for trying lots of moves to get out of check
def make_hypothetical_move(board, color, start, destination)
  piece = board.pieces.find{|piece| piece.position == start}
  board.squares[destination] = piece.char
  piece.position = destination
  board.squares[start] = " "
end

#does a move result in checkmate?
