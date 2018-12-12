require_relative 'pieces.rb'
require_relative 'helper.rb'

class King < Piece
  attr_accessor :position, :color, :char, :possible_moves, :moves
  def initialize(position, color)
    @position = position
    @color = color
    if color == 'white'
      @char = "\u2654"
    else @char = "\u265A"
    end
    @possible_moves = []
    @moves = 0
  end

  def get_possible_moves(board)
    mod = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,1],[1,-1],[-1,-1]]
    #do this for each set of mods
    mod.each do |pair|
      current_pos = to_coord(@position)
      current_pos = [(current_pos[0] + pair[0]), (current_pos[1] + pair[1])]
      @possible_moves << [@position, to_alg(current_pos)] if board.squares[to_alg(current_pos)] == " "
      @possible_moves << [@position, to_alg(current_pos)] if occupied_by_opponent?(board, to_alg(current_pos), @color)
    end

    #castling. this is terrible.
    if @position == :e1 && @moves == 0
      h1_piece = board.pieces.find{ |piece| piece.position == :h1}
      a1_piece = board.pieces.find{ |piece| piece.position == :a1}

      if (board.squares[:f1] == " " &&
         board.squares[:g1] == " " &&
         h1_piece.char == "\u2656" &&
         h1_piece.moves == 0)
         @possible_moves << [:e1,:g1]
      end

      if (board.squares[:d1] == " " &&
         board.squares[:c1] == " " &&
         board.squares[:b1] == " " &&
         a1_piece.char == "\u2656" &&
         a1_piece.moves == 0)
         @possible_moves << [:e1,:c1]
      end

    end

    if @position == :e8 && @moves == 0
      h8_piece = board.pieces.find {|piece| piece.position == :h8}
      a8_piece = board.pieces.find {|piece| piece.position == :a8}
      if (board.squares[:f8] == " " &&
         board.squares[:g8] == " " &&
         h1_piece.char == "\u265C" &&
         h1_piece.moves == 0)

         @possible_moves << [:e8,:g8]
      end
      if (board.squares[:d8] == " " &&
         board.squares[:c8] == " " &&
         board.squares[:b8] == " " &&
         a1_piece.char == "\u265C" &&
         a1_piece.moves == 0)

         @possible_moves << [:e8,:c8]
      end
    end
  end

  def castle_short(board, color)
    if color == 'white'
      king = board.pieces.find{|piece| piece.position == :e1}
      rook = board.pieces.find{|piece| piece.position == :h1}
      king.position = :g1
      rook.position = :f1
      king.moves += 1
      rook.moves += 1
      board.squares[:g1] = king.char
      board.squares[:f1] = rook.char
      board.squares[:h1] = " "
    elsif color == 'black'
      king = board.pieces.find{|piece| piece.position == :e8}
      rook = board.pieces.find{|piece| piece.position == :h8}
      king.position = :g8
      rook.position = :f8
      king.moves += 1
      rook.moves += 1
      board.squares[:g8] = king.char
      board.squares[:f8] = rook.char
      board.squares[:h8] = " "
    end
  end

  def castle_long(board, color)
    if color == 'white'
      king = board.pieces.find{|piece| piece.position == :e1}
      rook = board.pieces.find{|piece| piece.position == :a1}
      king.position = :c1
      rook.position = :d1
      king.moves += 1
      rook.moves += 1
      board.squares[:c1] = king.char
      board.squares[:d1] = rook.char
      board.squares[:a1] = " "
      board.squares[:b1] = " "
    elsif color == 'black'
      king = board.pieces.find{|piece| piece.position == :e8}
      rook = board.pieces.find{|piece| piece.position == :a8}
      king.position = :c8
      rook.position = :d8
      king.moves += 1
      rook.moves += 1
      board.squares[:c8] = king.char
      board.squares[:d8] = rook.char
      board.squares[:a8] = " "
      board.squares[:b8] = " "
    end
  end

end
