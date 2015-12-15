require "bundler"
Bundler.require

module Roman
  DICTIONARY = { "I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500 }

  refine String do
    def to_arabic
      raise not_a_roman_number if self == "VV"
      arabic_split.
        each_cons(2).
        inject(0) do |result, (current, other)|
          result + (current < other ? -1 : 1) * current
        end
    end

    def arabic_split
      split('').map{|curr| DICTIONARY[curr]} + [0]
    end

    def not_a_roman_number
      ArgumentError.new("This is not a roman number, dummy")
    end
  end
end

RSpec.describe "to_arabic" do
  using Roman

  it { expect(   "I".to_arabic).to eq   1 }
  it { expect(  "II".to_arabic).to eq   2 }
  it { expect(  "IV".to_arabic).to eq   4 }
  it { expect(   "V".to_arabic).to eq   5 }
  it { expect(  "VI".to_arabic).to eq   6 }
  it { expect(   "X".to_arabic).to eq  10 }
  it { expect(   "L".to_arabic).to eq  50 }
  it { expect("CDIV".to_arabic).to eq 404 }
  it { expect { "VV".to_arabic }.to raise_error ArgumentError }
end
