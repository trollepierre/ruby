require "bundler"
Bundler.require

require_relative "../lib/card"

RSpec.describe Card do
  it { expect(Card.new("2C") <=> Card.new("2C")).to eq 0 }
  it { expect(Card.new("3C") <=> Card.new("2C")).to eq 1 }
  it { expect(Card.new("TC") <=> Card.new("QC")).to eq -1 }
  it { expect(Card.new("QD") <=> Card.new("TD")).to eq 1 }
  it { expect(Card.new("QC") <=> Card.new("QD")).to eq 0 }
end
