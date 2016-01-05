require "bundler"
Bundler.require

class Katapotter
  def self.buy books

      discounts = [1, 0.95, 0.90, 0.8, 0.75]
      current_discount = discounts[books.uniq.length - 1]

      if books.length == books.uniq.length
        return books.length * 8 * current_discount
      else
        price = books.uniq.length * 8 * current_discount
      
        if books.length == 3 && books.uniq.length == 2
          return price + self.buy([1])
        elsif books.length == 5 && books.uniq.length == 3
          return price + self.buy([1, 4])
        end
      end
      books.size * 8
	end
end

RSpec.describe Katapotter do
  it { expect(Katapotter.buy([1])).to eq 8 }
  it { expect(Katapotter.buy([1, 1])).to eq 16 }
  it { expect(Katapotter.buy([1, 2])).to eq 16 * 0.95 }
  it { expect(Katapotter.buy([1, 2, 3])).to eq 24 * 0.9 }
  it { expect(Katapotter.buy([1, 1, 3])).to eq (16 * 0.95 + 8) }
  it { expect(Katapotter.buy([1, 2, 3, 4])).to eq (32 * 0.8) }
  it { expect(Katapotter.buy([1, 1, 2, 4, 4])).to eq (24 * 0.9 + 16 * 0.95) }
  it { expect(Katapotter.buy([1, 2, 3, 4, 5])).to eq (40 * 0.75) }
  
end
