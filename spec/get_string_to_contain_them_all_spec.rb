require "bundler"
Bundler.require

def get_string_to_contain_them_all number
	(1..number).
		to_a.
		reverse.
		map { |item| item.to_s }.
	  inject("") do |str, n|
			if str =~ /#{n[0]}\Z/
				str + n[1..-1]
			else
				"#{str}#{n unless str.include?(n)}" 
			end
		end
end

RSpec.describe "get_string_to_contain_them_all" do
  it { expect(get_string_to_contain_them_all(1)).to match /1/}
  it { expect(get_string_to_contain_them_all(2)).to match /2/}
  it { expect(get_string_to_contain_them_all(2)).to match /1/}
  it { expect(get_string_to_contain_them_all(1).length).to eq 1}
  it { expect(get_string_to_contain_them_all(10).length).to eq 10}
  (1..10).each do |n|
 	  it { expect(get_string_to_contain_them_all(10)).to match /#{n}/}
  end
  it { expect(get_string_to_contain_them_all(11).length).to eq 11}
  (1..11).each do |n|
 	  it { expect(get_string_to_contain_them_all(11)).to match /#{n}/}
  end
end
