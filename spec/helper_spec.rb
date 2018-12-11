require_relative '../chess.rb'

RSpec.describe Board do
  describe "#occupied_by_me?" do
    it "checks if a piece of a certain color is on the square" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_me?(g, :a2, 'white')).to eql(true)
    end
    it "checks if empty square is false for white" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_me?(g, :a3, 'white')).to eql(false)
    end
    it "checks black square" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_me?(g, :f8, 'black')).to eql(true)
    end
    it "checks empty square for black" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_me?(g, :f6, 'black')).to eql(false)
    end
  end

  describe "#occupied_by_king" do
    it "checks valid king for white" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_king?(g, :e8, 'white')).to eql(true)
    end

    it "checks invalid king for white" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_king?(g, :a4, 'white')).to eql(false)
    end

    it "checks valid king for black" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_king?(g, :e1, 'black')).to eql(true)
    end

    it "checks invalid king for black" do
      g = Board.new
      g.set_up_board
      expect(occupied_by_king?(g, :h5, 'black')).to eql(false)
    end

  end

  describe "#valid_square" do
    it "checks valid input" do
      expect(valid_square?(:f2)).to eql(true)
    end
    it "checks invalid input 1" do
      expect(valid_square?(:z2)).to eql(false)
    end
    it "checks invalid input 2" do
      expect(valid_square?(:z2)).to eql(false)
    end
    it "checks invalid input 3" do
      expect(valid_square?(:z)).to eql(false)
    end
    it "checks invalid input 4" do
      expect(valid_square?(nil)).to eql(false)
    end
    it "checks invalid input 5" do
      expect(valid_square?(:h9)).to eql(false)
    end
  end


end
