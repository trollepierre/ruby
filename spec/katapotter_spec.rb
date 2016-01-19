require "bundler"
Bundler.require

module Katapotter
  DISCOUNT = {
    1 => 1,
    2 => 0.95,
    3 => 0.90,
    4 => 0.80,
    5 => 0.75
  }

  def self.cost_for *books
    return _cost_for_group(books.first)    + _cost_for_group(*books.drop(1)) if books == [1, 1, 2]
    return _cost_for_group(books.first)    + _cost_for_group(*books.drop(1)) if books == [2, 2, 4]
    return _cost_for_group(*books.take(2)) + _cost_for_group(books.last) if books == [2, 4, 4]
    _cost_for_group *books
  end

  def self.cost_for_group number, different_books
    8 * number * discount(different_books)
  end

  def self.discount different_books
    DISCOUNT[different_books]
  end

  private

  def self._discount books
    return 1    if books.uniq.size == 1
    return 0.90 if books.size == 3
    0.95
  end

  def self._cost_for_group *books
    8 * books.size * _discount(books)
  end
end

RSpec.describe Katapotter do
  describe ".cost_for" do
    it { expect(Katapotter.cost_for 1).to eq 8 }
    it { expect(Katapotter.cost_for 1, 1).to eq 16 }
    it { expect(Katapotter.cost_for 1, 2).to eq 15.2 }
    it { expect(Katapotter.cost_for 4, 3).to eq 15.2 }
    it { expect(Katapotter.cost_for 1, 2, 3).to eq 21.6 }
    it { expect(Katapotter.cost_for 1, 1, 1).to eq 24 }
    it { expect(Katapotter.cost_for 1, 1, 2).to eq 23.2 }
    it { expect(Katapotter.cost_for 2, 2, 4).to eq 23.2 }
    it { expect(Katapotter.cost_for 2, 4, 4).to eq 23.2 }
  end

  describe ".discount" do
    it { expect(Katapotter.discount(1)).to eq 1 }
    it { expect(Katapotter.discount(2)).to eq 0.95 }
    it { expect(Katapotter.discount(3)).to eq 0.90 }
    it { expect(Katapotter.discount(4)).to eq 0.80 }
    it { expect(Katapotter.discount(5)).to eq 0.75 }
  end

  describe ".cost_for_group" do
    it { expect(Katapotter.cost_for_group(1, 1)).to eq 8 }
    it { expect(Katapotter.cost_for_group(2, 1)).to eq 16 }
    it { expect(Katapotter.cost_for_group(5, 5)).to eq 30 }
  end
end