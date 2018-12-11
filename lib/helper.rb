WHITE_PIECES = ["\u2654","\u2655","\u2656","\u2657","\u2658","\u2659"]
BLACK_PIECES = ["\u265A","\u265B","\u265C","\u265D","\u265E","\u265F"]

def to_alg(arr)
  letters = ['a','b','c','d','e','f','g','h']
  letter = letters[arr[0]-1]
  return (letter + arr[1].to_s).to_sym
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
