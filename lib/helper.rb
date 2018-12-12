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
def get_all_moves(board, color)
  move_list = []
  if color == 'white'
    pieces = board.pieces.find_all {|piece| piece.color == 'white'}
    pieces.each do |p|
    p.get_possible_moves(board)
    p.possible_moves.each do |m|
      move_list << m
      end
    end
  else
    pieces = board.pieces.find_all {|piece| piece.color == 'black'}
    pieces.each do |p|
    p.possible_moves = []
    p.get_possible_moves(board)
    p.possible_moves.each do |m|
      move_list << m
      end
    end
  end
  return move_list
end

#this is to potentially turn it off
def in_check?(board, color)
  if color == 'white'
    #get all of black's possible moves
    moves = get_all_moves(board, 'black')
    #get the position of the white king
    king = board.pieces.find {|piece| piece.char == "\u2654"}
    #for each of black moves, if the destination is where the king is, return true
    moves.each do |move|
      return true if move[1] == king.position
    end
    return false
  else
    moves = get_all_moves(board, 'white')
    king = board.pieces.find {|piece| piece.char == "\u265A"}
    moves.each do |move|
      return true if move[1] == king.position
    end
    return false
  end
end

#for trying lots of moves to get out of check
def make_hypothetical_move(board, start, destination)
  piece = board.pieces.find {|piece| piece.position == start}
  board.squares[destination] = piece.char
  piece.position = destination
  board.squares[start] = " "
end

#does a move result in checkmate?
def checkmated?(board, color)
  if in_check?(board, color)
    #get all possible moves of that color, if any of them result in not being in check, return false
    possible_escapes = get_all_moves(board, color)
    possible_escapes.each do |move|
      make_hypothetical_move(board, move[0], move[1])
      if in_check?(board, color) == false
        make_hypothetical_move(board, move[1], move[0])
        return false
      else
        make_hypothetical_move(board, move[1], move[0])
      end
    end
    return true
  end
end

#this is the same but for if you are NOT in check
def stalemated?(board, color)
  if in_check?(board, color) == false
    possible_escapes = get_all_moves(board, color)
    possible_escapes.each do |move|
      make_hypothetical_move(board, move[0], move[1])
      if in_check?(board, color) == false
        make_hypothetical_move(board, move[1], move[0])
        return false
      else
        make_hypothetical_move(board, move[1], move[0])
      end
    end
    return true
  end
end

def moves_into_check?(board, color, start, destination)
  make_hypothetical_move(board, start, destination)
  if in_check?(board, color) == true
    make_hypothetical_move(board, destination, start)
    return true
  else
    #undo it
    make_hypothetical_move(board, destination, start)
    return false
  end
end
