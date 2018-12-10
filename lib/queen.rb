require_relative 'pieces.rb'

class Queen < Piece
  attr_accessor :position, :color, :char
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2655"
    else @char = "\u265B"
    end
  end
end
