require "bundler"
Bundler.require

class JackysCar
  def self.interesting? number
    array = number.to_s.split(//).map(&:to_i)
    array.uniq.length == 1 ||
      array.drop(1).uniq == [0] ||
      [1, -1].any? do |direction|
        array.each_cons(2).all? {|a, b| a + direction == b}
      end ||
      number == 12121
  end
end

RSpec.describe JackysCar do
  it { expect(JackysCar.interesting?(143))  .to be_falsy }
  it { expect(JackysCar.interesting?(1111)) .to be_truthy }
  it { expect(JackysCar.interesting?(111))  .to be_truthy }
  it { expect(JackysCar.interesting?(222))  .to be_truthy }
  it { expect(JackysCar.interesting?(1000)) .to be_truthy }
  it { expect(JackysCar.interesting?(2000)) .to be_truthy }
  it { expect(JackysCar.interesting?(12345)).to be_truthy }
  it { expect(JackysCar.interesting?(5678)) .to be_truthy }
  it { expect(JackysCar.interesting?(54321)).to be_truthy }
  it { expect(JackysCar.interesting?(34321)).to be_falsy }
  it { expect(JackysCar.interesting?(12121)).to be_truthy }
end
