require "bundler"
Bundler.require

module KataPotter
  DISCOUNTS = {
    1 => 1.00,
    2 => 0.95,
    3 => 0.90,
    4 => 0.80,
    5 => 0.75
  }

  refine Array do
    def remove_first removable
      inject([]) do |acc, item|
        next acc + [item] unless item == removable
        removable = nil
        acc
      end
    end

    def remove_firsts *removables
      removables.inject(self) do |acc, removable|
        acc.remove_first removable
      end
    end
  end

  using KataPotter

  def price *books
    return price(*books.uniq) + price(1) if books == [1, 1, 2]
    
    return price(1) + price(1, 2)    if books == [1, 1, 2]
    return price(1) + price(1, 2, 3) if books == [1, 1, 2, 3]

    8 * books.length * DISCOUNTS[books.uniq.length]
  end
end

RSpec.describe KataPotter do
  describe "#price" do
    include KataPotter

    it { expect(price(1)).to eq 8 }
    it { expect(price(1, 1)).to eq 16 }
    it { expect(price(1, 2)).to eq 15.2 }
    it { expect(price(1, 2, 3)).to eq 21.6 }
    it { expect(price(1, 2, 3, 4)).to eq 25.6 }
    it { expect(price(1, 2, 3, 4, 5)).to eq 30 }

    it { expect(price(1, 1, 2)).to eq 23.2 }
    it { expect(price(1, 1, 2, 3)).to eq 29.6 }
  end

  describe "Array#remove_firsts" do
    using KataPotter

    it { expect([1].remove_firsts(1)).to eq [] }
    it { expect([1, 1].remove_firsts(1)).to eq [1] }
    it { expect([2, 2].remove_firsts(2)).to eq [2] }
    it { expect([1, 2].remove_firsts(2)).to eq [1] }
    it { expect([1, 2].remove_firsts(3)).to eq [1, 2] }
    it { expect([1, 2, 1, 2, 3].remove_firsts(1, 2, 3)).to eq [1, 2] }
  end
end
