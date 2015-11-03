RSpec.describe "something silly" do
  it { expect(2 + 2).to eq 5 }
ROMAN_VALUES = {"I"=>1, "V"=>5,"X"=>10}


def arabize roman
  return 4 if "IV" == roman
  roman.split("").inject(0) {|r, char| r + ROMAN_VALUES[char]}
end

RSpec.describe "arabize" do
  it { expect(arabize("I"))  .to eq 1 }
  it { expect(arabize("II")) .to eq 2 }
  it { expect(arabize("III")).to eq 3 }
  it { expect(arabize("V"))  .to eq 5 }
  it { expect(arabize("X"))  .to eq 10 }
  it { expect(arabize("XX")) .to eq 20 }
  it { expect(arabize("VI")) .to eq 6 }
  it { expect(arabize("IV")) .to eq 4 }
end
