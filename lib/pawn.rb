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

  def get_possible_moves(board)
    current_pos = to_coord(@position)

    if @color == 'white'
      #if on second rank, two moves, otherwise one
      if current_pos[1] == 2
        @possible_moves << to_alg([current_pos[0], (current_pos[1] + 2)])
        @possible_moves << to_alg([current_pos[0], (current_pos[1] + 1)])
      elsif [3,4,5,6,7].include?(current_pos[1])
        @possible_moves << to_alg([current_pos[0], (current_pos[1] + 1)])
      end
      #check if there's an enemy diagonally
      if BLACK_PIECES.include?(board.squares[to_alg([current_pos[0] + 1, (current_pos[1] + 1)])])
        @possible_moves << to_alg([current_pos[0] + 1, (current_pos[1] + 1)])
      elsif BLACK_PIECES.include?(board.squares[to_alg([current_pos[0] - 1, (current_pos[1] + 1)])])
        @possible_moves << to_alg([current_pos[0] - 1, (current_pos[1] + 1)])
      end

    elsif @color == 'black'
      #if on seventh rank, two moves, otherwise one
      if current_pos[1] == 7
        @possible_moves << to_alg([current_pos[0], (current_pos[1] - 2)])
        @possible_moves << to_alg([current_pos[0], (current_pos[1] - 1)])
      elsif [6,5,4,3,2].include?(current_pos[1])
        @possible_moves << to_alg([current_pos[0], (current_pos[1] - 1)])
      end

      #check if there's an enemy diagonally
      if WHITE_PIECES.include?(board.squares[to_alg([current_pos[0] -1, (current_pos[1] - 1)])])
        @possible_moves << to_alg([current_pos[0] - 1, (current_pos[1] - 1)])
      elsif BLACK_PIECES.include?(board.squares[to_alg([current_pos[0] + 1, (current_pos[1] - 1)])])
        @possible_moves << to_alg([current_pos[0] + 1, (current_pos[1] - 1)])
      end
    end
  end
end
