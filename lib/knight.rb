require_relative 'pieces.rb'

class Knight < Piece
  attr_accessor :position, :color, :char
  def initialize(position, color)
    @possible_moves = []
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2658"
    else @char = "\u265E"
    end
  end

  def get_possible_moves
    coordinates = @position
  end
end
