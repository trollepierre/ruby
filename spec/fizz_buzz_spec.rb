require "bundler"
Bundler.require

module FizzBuzz
  def self.fizz_buzz number
    result = {
      3  => "fizz",
      5  => "buzz"
    }.inject("") do |accumulator, (divider, string)|
      accumulator +
      (if number % divider == 0 then string else "" end)
    end
    return result unless result == ""
    number.to_s
  end

  class FizzBuzzer
    def initialize number
      @number = number
    end

    def to_s
      FizzBuzz.fizz_buzz @number
    end
  end

  module Refiner
    refine Fixnum do
      def to_s
        result = {
          3  => "fizz",
          5  => "buzz"
        }.inject("") do |accumulator, (divider, string)|
          accumulator +
          (if self % divider == 0 then string else "" end)
        end
        return result unless result == ""
        super
      end
    end
  end
end

RSpec.describe FizzBuzz do
  context "with a method" do
    it { expect(FizzBuzz.fizz_buzz(1)) .to eq "1" }
    it { expect(FizzBuzz.fizz_buzz(2)) .to eq "2" }
    it { expect(FizzBuzz.fizz_buzz(3)) .to eq "fizz" }
    it { expect(FizzBuzz.fizz_buzz(6)) .to eq "fizz" }
    it { expect(FizzBuzz.fizz_buzz(5)) .to eq "buzz" }
    it { expect(FizzBuzz.fizz_buzz(15)).to eq "fizzbuzz" }
  end

  context "with a decorator class" do
    it { expect(FizzBuzz::FizzBuzzer.new(1) .to_s).to eq "1" }
    it { expect(FizzBuzz::FizzBuzzer.new(2) .to_s).to eq "2" }
    it { expect(FizzBuzz::FizzBuzzer.new(3) .to_s).to eq "fizz" }
    it { expect(FizzBuzz::FizzBuzzer.new(6) .to_s).to eq "fizz" }
    it { expect(FizzBuzz::FizzBuzzer.new(5) .to_s).to eq "buzz" }
    it { expect(FizzBuzz::FizzBuzzer.new(15).to_s).to eq "fizzbuzz" }
  end

  context "with a refinement" do
    using FizzBuzz::Refiner

    it { expect(1 .to_s).to eq "1" }
    it { expect(2 .to_s).to eq "2" }
    it { expect(3 .to_s).to eq "fizz" }
    it { expect(6 .to_s).to eq "fizz" }
    it { expect(5 .to_s).to eq "buzz" }
    it { expect(15.to_s).to eq "fizzbuzz" }
  end
end
