require_relative "card"

class PokerHand
  def initialize string
    @values = string.
      split.
      map { |card_string| Card.new(card_string) }.
      sort.
      reverse
  end

  def <=> other
    -other.compare(@values)
  end

  def compare other_values
    @values <=> other_values
  end
end
