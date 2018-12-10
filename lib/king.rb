require_relative 'king.rb'

class King < Piece
  attr_accessor :position, :color, :char
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2654"
    else @char = "\u265A"
    end
  end
end
