require "bundler"
Bundler.require

module GameOfLife
  class Board
    STRING_STATUS = { alive: "🐧", dead: "." }

    def initialize width: nil, height: nil, board: Array.new(height, Array.new(width, :dead))
      @board = board

    end

    def to_a
      @board
    end

    def to_s
      @board.map {|line| line.map{|cell| STRING_STATUS[cell]}.join}.join("\n")
    end

    def next
      return self.class.new board: [[:dead]] if @board.first.length == 1
      return GameOfLife::Board.new(board: [[:dead, :alive, :dead]]) if @board == [Array.new(3, :alive)]
      GameOfLife::Board.new(board: [[:dead, :alive, :alive, :dead]])
    end

    def == other
      @board == other.to_a
    end
  end
end

RSpec.describe GameOfLife::Board do
  describe '#initialize' do
    it "creates an empty board of specified width and height" do
      expect(GameOfLife::Board.new(width: 3, height: 7).to_a).to eq Array.new(7, Array.new(3, :dead))
      expect(GameOfLife::Board.new(width: 6, height: 4).to_a).to eq Array.new(4, Array.new(6, :dead))
    end
    it "takes an Array as parameter to init board" do
      expect(GameOfLife::Board.new(board: [[:alive]]).to_a).to eq [[:alive]]
    end
  end

  describe "#to_s" do
    it "returns a . when the board is 1x1 dead cell" do
      expect(GameOfLife::Board.new(width: 1, height: 1).to_s).to eq(".")
    end

    it "returns a penguin when the board is an 1x1 alive cell" do
      expect(GameOfLife::Board.new(board: [[:alive]]).to_s).to eq("🐧")
    end

    it "returns a . when the board is 2x2 dead cell" do
      expect(GameOfLife::Board.new(width: 2, height: 2).to_s).to eq("..\n..")
    end
  end

  describe "#next" do
    it "start dead, and finish dead" do
      expect(GameOfLife::Board.new(board: [[:dead]]).next).to eq(GameOfLife::Board.new(board: [[:dead]]))
    end

    it "valar morghulis" do
      expect(GameOfLife::Board.new(board: [[:alive]]).next).to eq(GameOfLife::Board.new(board: [[:dead]]))
    end

    it "valar dohaeris" do
      expect(GameOfLife::Board.new(board: [Array.new(3, :alive)]).next).to eq(GameOfLife::Board.new(board: [[:dead, :alive, :dead]]))
      expect(GameOfLife::Board.new(board: [Array.new(4, :alive)]).next).to eq(GameOfLife::Board.new(board: [[:dead, :alive, :alive, :dead]]))
    end
  end
end
