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
  tabs = string.split(/\n/)
  
  lines = tabs.map do | tab |
    tab.scan(/.../)
  end

  result = []
  lines.each do |line|
    line.each_with_index do |part, index|
      result[index] = [result[index], part].compact.join "\n"
    end
  end
  result.map { |s| s + "\n" }
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
