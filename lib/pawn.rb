require_relative 'pieces.rb'

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
    current_pos = @position.to_coord
    if @color = 'white'
      if current_pos[1] = 2
        @possible_moves << [current_pos[0], (current_pos[1] + 2)].to_sym
      elsif [3,4,5,6,7].include?(current_pos[1])
        @possible_moves << [current_pos[0], (current_pos[1] + 1)].to_sym
      end
    end


  end
end
