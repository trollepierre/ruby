require "bundler"
Bundler.require

require_relative "../lib/poker_hand"

RSpec.describe PokerHand do
  def hand string
    PokerHand.new string
  end

  context "comparing highcards" do
    it { expect(hand("2C 3S 4D 5H 7C") <=>
                hand("2C 3S 4D 5H 7C")).to eq 0 }
    it { expect(hand("2C 3S 4D 5H 8C") <=>
                hand("2C 3S 4D 5H 7C")).to eq 1 }
    it { expect(hand("7C 2C 3S 4D 5H") <=>
                hand("2C 3S 4D 5H 7C")).to eq 0 }
    it { expect(hand("9C 2C 3S 4D 5H") <=>
                hand("3C 4S 5D 6H 8C")).to eq 1 }
    it { expect(hand("TC 2C 3S 4D 5H") <=>
                hand("3C 4S 5D 6H QC")).to eq -1 }
  end
end
