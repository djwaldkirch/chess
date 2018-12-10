class Piece
  attr_accessor :position, :color, :char
  def initialize
  end
end

require_relative 'pawn.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'rook.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
