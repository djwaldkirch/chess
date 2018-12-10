require_relative 'rook.rb'

class Rook < Piece
  attr_accessor :position, :color, :char
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2656"
    else @char = "\u265C"
    end
  end
end
