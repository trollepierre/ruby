require "bundler"
Bundler.require

def card_value card
  return 1 if card == "A"
  return 10 if card.to_i == 0
  card.to_i
end

def hand_value hand
  value = sum hand.map { |card| card_value card }
  value_with_ace = value + 10 if hand.include? 'A'

  return 22 if value_with_ace == 21 && hand.length == 2
  return 0 if value > 21
  return value_with_ace if value_with_ace && value_with_ace <= 21
  
  value
end

def sum tab
  tab.inject{|acc, val| acc+val}
end

def compare player_hand, bank_hand
  hand_value(player_hand) <=> hand_value(bank_hand)
end


RSpec.describe "BlackJack" do
  describe 'simple hands' do 
    it { expect(compare(%w[2 3],%w[8 7])).to eq -1 }
    it { expect(compare(%w[8 7],%w[2 3])).to eq 1 }
    it { expect(compare(%w[8 7],%w[8 7])).to eq 0 }
  end

  describe 'over 21 hands' do
    it { expect(compare(%w[8 7 8],%w[8 7])).to eq -1 }
    it { expect(compare(%w[8 7], %w[8 7 8])).to eq 1 }
    it { expect(compare(%w[T 2], %w[3 2])).to eq 1 }
    it { expect(compare(%w[Q 2], %w[3 2])).to eq 1 }
  end 

  describe 'fucking ace case' do
    it { expect(compare(%w[A T T], %w[8 6])).to eq 1 }
    it { expect(compare(%w[A 5 5], %w[8 6])).to eq 1 }
    it { expect(compare(%w[A A], %w[8 6])).to eq -1 }
  end

  describe 'blackjack hand' do
    it { expect(compare(%w[A T], %w[T T 1])).to eq 1 }
    it { expect(compare(%w[A T], %w[Q A])).to eq 0 }
  end
end
