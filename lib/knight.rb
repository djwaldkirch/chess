require_relative 'pieces.rb'
require_relative 'helper.rb'

class Knight < Piece
  attr_accessor :position, :color, :char, :possible_moves, :moves
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2658"
    else @char = "\u265E"
    end
    @possible_moves = []
    @moves = 0
  end

  def get_possible_moves(board)
    current_pos = to_coord(@position)
    mod = [[2,1],[1,2],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
    mod.each do |pair|
      new_pos = to_alg([current_pos[0] + pair[0], current_pos[1] + pair[1]])
      if occupied_by_me?(board, new_pos, @color) == false && valid_square?(new_pos) == true
        @possible_moves << [@position, new_pos]
      end
    end
  end
end
