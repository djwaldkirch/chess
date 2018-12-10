def to_alg(arr)
  letters = ['a','b','c','d','e','f','g','h']
  letter = letters[arr[0]-1]
  return (letter + arr[1]).to_s
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

def occupied_by_me?(board,position, color)

end

def occupied_by_opponent?(board, position, color)
  if board.squares[position] != " "
    return true
  else
    return false
  end
end

def occupied_by_king
