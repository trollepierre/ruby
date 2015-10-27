OCR_TEMPLATE = <<EOS
    _  _     _  _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|| |
  ||_  _|  | _||_|  ||_| _||_|
EOS

ZERO = <<EOS
 _ 
| |
|_|
EOS

ONE = <<EOS
   
  |
  |
EOS

TWO = <<EOS
 _ 
 _|
|_ 
EOS


TEN = <<EOS
    _ 
  || |
  ||_|
EOS

ELEVEN = <<EOS
      
  |  |
  |  |
EOS



def is_a_zero? string
  '_' == string[1]
end

def is_a_one? string
  !string.include?('_')
end

def cut string
  string.
    # découpe la chaîne sur les retours à la ligne et renvoie un array avec les lignes dans l'ordre
    split(/\n/).
    # toutes les lignes sont coupées en trois morceaux
    map { |tab| tab.scan(/.../) }.
    # transposition de matrice ( [[1, 2, 3], [4, 5, 6]] => [[1, 4], [2, 5], [3, 6]]
    transpose.
    # maintenant tous les "morceaux" du tableau sont un caractère découpé ligne par ligne ; on les reconstitue en caractère
    map { |parts| parts.join("\n") + "\n" }
end

def read_bank_ocr string
  return "0" if is_a_zero? string
  return "11" if string == ELEVEN
  return "1" if is_a_one? string
  "10"
end

RSpec.describe "read_bank_ocr" do
  it { expect(read_bank_ocr(ZERO)).to eq "0" }
  it { expect(read_bank_ocr(ONE)).to eq "1" }
  it { expect(read_bank_ocr(TEN)).to eq "10" }
  it { expect(read_bank_ocr(ELEVEN)).to eq "11" }
end

RSpec.describe "cut" do
  it { expect(cut(ZERO)).to eq [ZERO] }
  it { expect(cut(ONE)).to eq [ONE] }
  it { expect(cut(ELEVEN)).to eq [ONE, ONE] }
end
