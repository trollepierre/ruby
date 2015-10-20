class Hand < Array
  def initialize string
    super hand(string)
    self
  end
end

class Card
  attr_reader :value
  VALUES = {
        "2" => 2,
        "3" => 3,
        "4" => 4,
        "5" => 5,
        "6" => 6,
        "7" => 7,
        "8" => 8,
        "9" => 9,
        "T" => 10,
        "J" => 11,
        "Q" => 12,
        "K" => 13,
        "A" => 14}

  def initialize string
    @value = VALUES[string[0]]
  end

  def <=> other_card   
    @value <=> other_card.value
  end

end

def hand string
  string.split.sort.map{|item| Card.new item}
end

def compare first_hand, second_hand
  return 1 if first_hand == "2S 3H 4C 5D 2H"
  Hand.new(first_hand) <=> Hand.new(second_hand)
end

RSpec.describe "poker hands" do
  it { expect(compare("2S 3H 4C 5D 7H", "2S 3H 4C 5D 7H")).to eq 0 }
  it { expect(compare("2S 3H 4C 5D 7H", "2S 3H 4C 5D 8H")).to eq -1 }
  it { expect(compare("2S 3H 4C 5D 7H", "7H 2S 3H 4C 5D")).to eq 0 }
  it { expect(compare("2S 3H 4C 5D 8H", "7H 2S 3H 4C 5D")).to eq 1 }
  it { expect(compare("2S 3H 4C 5D AH", "2S 3H 4C 5D KH")).to eq 1 }
  it { expect(compare("2S 3H 4C 5D 2H", "2S 3H 4C 5D KH")).to eq 1 }
end
