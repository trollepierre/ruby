require "bundler"
Bundler.require

class Monnayeur
  def initialize coins
    @coins = coins.sort.reverse
  end

  def sum coins
    coins.inject(0) { |acc, coin| acc + coin }
  end

# Implementation EauPrecieuse
  def change amount
    result = @coins.inject([]) do |acc, coin|
      acc + (sum(acc) < amount ? [coin] : [])
    end

    raise "Not enough coins" if sum(result) != amount
    result
  end
end

RSpec.describe Monnayeur do
  it { expect(Monnayeur.new([]).change(0)).to eq [] }
  it { expect(Monnayeur.new([1]).change(1)).to eq [1] }
  it { expect(Monnayeur.new([1, 1]).change(1)).to match_array [1] }
  it { expect(Monnayeur.new([1, 1]).change(2)).to match_array [1,1] }
  it { expect(Monnayeur.new([1, 2]).change(3)).to match_array [2,1] }
  it { expect(Monnayeur.new([1, 2, 1]).change(2)).to match_array [2] }
  it { expect{Monnayeur.new([1]).change(2)}.to raise_error "Not enough coins" }
  it { expect{Monnayeur.new([2]).change(1)}.to raise_error "Not enough coins" }
end
