require "bundler"
Bundler.require

DISCOUNTS = {
  1 => 1,
  2 => 0.95,
  3 => 0.90,
  4 => 0.80,
  5 => 0.75,
}

def katapotter *books
  books_number  = books.length
  series_number = books.uniq.length
  return katapotter(*books.uniq) + katapotter(*remove_all(books, books.uniq)) if books_number != series_number
  8 * ((books_number - series_number) +
        series_number * DISCOUNTS[series_number])
end

def remove_all remove_from, to_remove
  to_remove.inject(remove_from) { |r, b| remove_first r, b }
end

def remove_first tab, value
  tab.dup.tap { |t| t.delete_at(tab.find_index(value)) rescue nil }
end

RSpec.describe "Katapotter" do
  describe '#katapotter' do
    it { expect(katapotter(1))            .to eq  8 }
    it { expect(katapotter(2))            .to eq  8 }
    it { expect(katapotter(1, 2))         .to eq 15.2 }
    it { expect(katapotter(1, 2, 4))      .to eq 21.6 }
    it { expect(katapotter(1, 2, 3, 4))   .to eq 25.6 }
    it { expect(katapotter(1, 2, 3, 4, 5)).to eq 30 }
    it { expect(katapotter(1, 1))         .to eq 16 }
    it { expect(katapotter(2, 2))         .to eq 16 }
    it { expect(katapotter(2, 2, 1))      .to eq 23.2 }
    it { expect(katapotter(2, 2, 1, 1))   .to eq 30.4 }
  end

  describe "#remove_first" do
    context "what it does" do
      it { expect(remove_first([2, 2, 1, 1], 2)).to eq [2, 1, 1] }
      it { expect(remove_first([2, 2, 1, 1], 3)).to eq [2, 2, 1, 1] }
    end

    context "what it does not" do
      let(:original) { [1,2,1,2,4] }

      it { expect { remove_first(original, 4) }.not_to change original, :length }
    end
  end

end


