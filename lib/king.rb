require_relative 'king.rb'

class King < Piece
  attr_accessor :position, :color, :char, :possible_moves
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2654"
    else @char = "\u265A"
    end
    @possible_moves = []
  end

  def get_possible_moves(board)
    mod = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,1],[1,-1],[-1,-1]]
    #do this for each set of mods
    mod.each do |pair|
      current_pos = to_coord(@position)
      current_pos = [(current_pos[0] + pair[0]), (current_pos[1] + pair[1])]
      @possible_moves << to_alg(current_pos) if board.squares[to_alg(current_pos)] == " "
      @possible_moves << to_alg(current_pos) if occupied_by_opponent?(board, to_alg(current_pos), @color)
    end
  end

end
