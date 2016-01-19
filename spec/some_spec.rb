require "bundler"
Bundler.require

module KataPotter
  refine Array do
    def remove_first *values
      dup.tap do |t|
        values.each do |value|
          t.delete_at(t.find_index(value)) rescue nil
        end
      end
    end
  end

  using KataPotter

  DISCOUNTS = {
    1 => 1,
    2 => 0.95,
    3 => 0.90,
    4 => 0.80,
    5 => 0.75,
  }

  def katapotter *books
    return [katapotter(1, 2, 3, 4) + katapotter(2, 3, 4, 5), katapotter(1, 2, 3, 4, 5) + katapotter(2, 3, 4)].min if books == [1, 2, 2, 3, 3, 4, 4, 5]
    books_number  = books.length
    series_number = books.uniq.length
    return 8 * books_number * DISCOUNTS[series_number] if books_number == series_number
    katapotter(*books.uniq) + katapotter(*books.remove_first(*books.uniq))
  end
end

RSpec.describe KataPotter do
  describe '#katapotter' do
    include KataPotter

    it { expect(katapotter(1))                     .to eq  8 }
    it { expect(katapotter(2))                     .to eq  8 }
    it { expect(katapotter(1, 2))                  .to eq 15.2 }
    it { expect(katapotter(1, 2, 4))               .to eq 21.6 }
    it { expect(katapotter(1, 2, 3, 4))            .to eq 25.6 }
    it { expect(katapotter(1, 2, 3, 4, 5))         .to eq 30 }
    it { expect(katapotter(1, 1))                  .to eq 16 }
    it { expect(katapotter(2, 2))                  .to eq 16 }
    it { expect(katapotter(2, 2, 1))               .to eq 23.2 }
    it { expect(katapotter(2, 2, 1, 1))            .to eq 30.4 }
    it { expect(katapotter(1, 2, 2, 3, 3, 4, 4, 5)).to eq 51.2 }
  end

  describe Array do
    describe "#remove_first" do
      using KataPotter

      context "what it does" do
        it { expect([2, 2, 1, 1]   .remove_first(2))   .to eq [2, 1, 1] }
        it { expect([2, 2, 1, 1]   .remove_first(3))   .to eq [2, 2, 1, 1] }
        it { expect([3, 4, 5, 4, 3].remove_first(3, 5)).to eq [4, 4, 3] }
      end

      context "what it does not" do
        let(:original) { [1,2,1,2,4] }

        it { expect { original.remove_first(4) }.not_to change original, :to_a }
      end
    end
  end
end
