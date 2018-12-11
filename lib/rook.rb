require_relative 'pieces.rb'
require_relative 'helper.rb'

class Rook < Piece
  attr_accessor :position, :color, :char, :possible_moves

  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2656"
    else @char = "\u265C"
    end
    @possible_moves = []
  end

  def get_possible_moves(board)
    mod = [[1,0],[-1,0],[0,1],[0,-1]]
    #do this for each set of mods
    mod.each do |pair|
      current_pos = to_coord(@position)
      current_pos = [(current_pos[0] + pair[0]), (current_pos[1] + pair[1])]
      #add any empty spaces along the way, stop at non-empty space
      while board.squares[to_alg(current_pos)] == " "
        @possible_moves << to_alg(current_pos)
        current_pos = [current_pos[0] + pair[0], (current_pos[1] + pair[1])]
      end
      #check the space it stopped at, if it's an enemy, add it to possible moves
      if occupied_by_opponent?(board, to_alg(current_pos), @color)
        @possible_moves << to_alg(current_pos)
      end
    end
  end
end
