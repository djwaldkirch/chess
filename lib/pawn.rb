require_relative 'pieces.rb'
require_relative 'helper.rb'

class Pawn < Piece
  attr_accessor :position, :color, :char, :possible_moves
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2659"
    else @char = "\u265F"
    end

    @possible_moves = []
  end

  def get_possible_moves
    current_pos = to_coord(position)
    if @color = 'white'
      if current_pos[1] == 2
        @possible_moves << to_alg([current_pos[0], (current_pos[1] + 2)])
      elsif [3,4,5,6,7].include?(current_pos[1])
        @possible_moves << to_alg([current_pos[0], (current_pos[1] + 1)])
      end
    end


  end
end
