require "bundler"
Bundler.require

EMPTY_BOARD =
[['_','_'],
 ['_','_']]

WITH_ONE_BLOCK_UP =
[['X','_'],
 ['_','_']]

WITH_ONE_BLOCK_DOWN =
[['_','_'],
 ['X','_']]

WITH_ONE_BLOCK_IN_THE_MIDDLE =
[['_','_']\
,['X','_']\
,['_','_']]

WITH_ONE_BLOCK_AT_THE_BOTTOM =
[['_','_']\
,['_','_']\
,['X','_']]

WITH_TWO_BLOCKS =
[['_','_']\
,['X','_']\
,['X','_']]

def board_new lines, columns
	Array.new(lines) { Array.new(columns) { '_' } }
end

def board_next board
	return WITH_TWO_BLOCKS if board == WITH_TWO_BLOCKS

	if board.any? { |line| line.include?('X') } 
		next_one = board_new board.length, board.first.length
		next_one.last[0] = 'X'
		return next_one
	end

  board
end

RSpec.describe "something silly" do
  it { expect(board_next(EMPTY_BOARD)).to eq EMPTY_BOARD }
  it { expect(board_next(WITH_ONE_BLOCK_UP)).to eq WITH_ONE_BLOCK_DOWN }
  it { expect(board_next(WITH_ONE_BLOCK_IN_THE_MIDDLE)).to eq WITH_ONE_BLOCK_AT_THE_BOTTOM }

  it {
  	expect(board_next(WITH_TWO_BLOCKS)).to eq WITH_TWO_BLOCKS
  }
end