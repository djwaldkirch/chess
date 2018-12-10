require_relative 'pieces.rb'

class Bishop
  attr_accessor :position, :color, :char
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2657"
    else @char = "\u265D"
    end
  end
end
