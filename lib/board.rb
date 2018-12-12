require_relative 'helper.rb'
require_relative 'pieces.rb'

class Board
  attr_accessor :squares, :pieces, :check

  def initialize
    @pieces = []
    @squares = {a1:" ", a2:" ", a3:" ", a4:" ", a5:" ", a6:" ", a7:" ", a8:" ",
               b1:" ", b2:" ", b3:" ", b4:" ", b5:" ", b6:" ", b7:" ", b8:" ",
               c1:" ", c2:" ", c3:" ", c4:" ", c5:" ", c6:" ", c7:" ", c8:" ",
               d1:" ", d2:" ", d3:" ", d4:" ", d5:" ", d6:" ", d7:" ", d8:" ",
               e1:" ", e2:" ", e3:" ", e4:" ", e5:" ", e6:" ", e7:" ", e8:" ",
               f1:" ", f2:" ", f3:" ", f4:" ", f5:" ", f6:" ", f7:" ", f8:" ",
               g1:" ", g2:" ", g3:" ", g4:" ", g5:" ", g6:" ", g7:" ", g8:" ",
               h1:" ", h2:" ", h3:" ", h4:" ", h5:" ", h6:" ", h7:" ", h8:" ",
    }
    @check = false

  end

  def display
    divider = " |---|---|---|---|---|---|---|---|"
    puts divider
    puts "8| #{@squares[:a8]} | #{@squares[:b8]} | #{@squares[:c8]} | #{@squares[:d8]} | #{@squares[:e8]} | #{@squares[:f8]} | #{@squares[:g8]} | #{@squares[:h8]} |"
    puts divider
    puts "7| #{@squares[:a7]} | #{@squares[:b7]} | #{@squares[:c7]} | #{@squares[:d7]} | #{@squares[:e7]} | #{@squares[:f7]} | #{@squares[:g7]} | #{@squares[:h7]} |"
    puts divider
    puts "6| #{@squares[:a6]} | #{@squares[:b6]} | #{@squares[:c6]} | #{@squares[:d6]} | #{@squares[:e6]} | #{@squares[:f6]} | #{@squares[:g6]} | #{@squares[:h6]} |"
    puts divider
    puts "5| #{@squares[:a5]} | #{@squares[:b5]} | #{@squares[:c5]} | #{@squares[:d5]} | #{@squares[:e5]} | #{@squares[:f5]} | #{@squares[:g5]} | #{@squares[:h5]} |"
    puts divider
    puts "4| #{@squares[:a4]} | #{@squares[:b4]} | #{@squares[:c4]} | #{@squares[:d4]} | #{@squares[:e4]} | #{@squares[:f4]} | #{@squares[:g4]} | #{@squares[:h4]} |"
    puts divider
    puts "3| #{@squares[:a3]} | #{@squares[:b3]} | #{@squares[:c3]} | #{@squares[:d3]} | #{@squares[:e3]} | #{@squares[:f3]} | #{@squares[:g3]} | #{@squares[:h3]} |"
    puts divider
    puts "2| #{@squares[:a2]} | #{@squares[:b2]} | #{@squares[:c2]} | #{@squares[:d2]} | #{@squares[:e2]} | #{@squares[:f2]} | #{@squares[:g2]} | #{@squares[:h2]} |"
    puts divider
    puts "1| #{@squares[:a1]} | #{@squares[:b1]} | #{@squares[:c1]} | #{@squares[:d1]} | #{@squares[:e1]} | #{@squares[:f1]} | #{@squares[:g1]} | #{@squares[:h1]} |"
    puts divider
    puts "   a   b   c   d   e   f   g   h  "
  end

  def set_up_board
    white_pawns = [:a2, :b2, :c2, :d2, :e2, :f2, :g2, :h2]
    white_pawns.each do |x|
      pawn = Pawn.new(x, 'white')
      @squares[x] = pawn.char
      @pieces << pawn
    end

    black_pawns = [:a7, :b7, :c7, :d7, :e7, :f7, :g7, :h7]
    black_pawns.each do |x|
      pawn = Pawn.new(x, 'black')
      @squares[x] = pawn.char
      @pieces << pawn
    end

    white_rooks = [:a1, :h1]
    white_rooks.each do |x|
      rook = Rook.new(x, 'white')
      @squares[x] = rook.char
      @pieces << rook
    end

    black_rooks = [:a8, :h8]
    black_rooks.each do |x|
      rook = Rook.new(x, 'black')
      @squares[x] = rook.char
      @pieces << rook
    end

    white_knights = [:b1, :g1]
    white_knights.each do |x|
      knight = Knight.new(x, 'white')
      @squares[x] = knight.char
      @pieces << knight
    end

    black_knights = [:b8, :g8]
    black_knights.each do |x|
      knight = Knight.new(x, 'black')
      @squares[x] = knight.char
      @pieces << knight
    end

    white_bishops = [:c1, :f1]
    white_bishops.each do |x|
      bishop = Bishop.new(x, 'white')
      @squares[x] = bishop.char
      @pieces << bishop
    end

    black_bishops = [:c8, :f8]
    black_bishops.each do |x|
      bishop = Bishop.new(x, 'black')
      @squares[x] = bishop.char
      @pieces << bishop
    end

    white_king = King.new(:e1, 'white')
    @squares[:e1] = white_king.char
    @pieces << white_king

    black_king = King.new(:e8, 'black')
    @squares[:e8] = black_king.char
    @pieces << black_king

    white_queen = Queen.new(:d1, 'white')
    @squares[:d1] = white_queen.char
    @pieces << white_queen

    black_queen = Queen.new(:d8, 'black')
    @squares[:d8] = black_queen.char
    @pieces << black_queen

  end

  def promote_pawns
    pawns = @pieces.find_all {|piece| (piece.char == "\u2659" || piece.char == "\u265F")}
    promoted = pawns.find {|pawn| pawn.position.to_s[1] == "8" || pawn.position.to_s[1] == "1"  }

    if promoted != nil
      new_queen = Queen.new(promoted.position, promoted.color)
      @squares[promoted.position] = new_queen.char
      @pieces << new_queen
      promoted.position = nil
      promoted.char = " "
      promoted.color = nil
    end
  end

end
