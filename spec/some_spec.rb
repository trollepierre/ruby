require "bundler"
Bundler.require

class Field
  def initialize(width, height)
    @cells = Array.new(width) { Array.new(height) { :dead } }
  end

  def [] (x,y)
    @cells[x][y]
  end

  def live! (x,y)
    self[x,y]= :alive
    return self
  end

  def die! (x,y)
    self[x,y]= :dead
    return self
  end

  def next
    bozo_clone.tap do |field|
      field.live!(0,1).live!(1,1).live!(2,1) if self[1,0] == :alive
    end
  end

  def []= (x,y,state)
    @cells[x][y] = state
  end

  def bozo_clone
    self.class.new(@cells.length, @cells.first.length)
  end

  def neighbors(x, y)
    result = 0
    (x-1..x+1).each do |row| 
      (y-1..y+1).each do |col|
        result+=1 if self[row,col] == :alive && !(row == x && col == y)
      end
    end
    result
  end
end

RSpec.describe Field do
  it { expect(Field.new(5,5)[0,0]).to eq :dead }
  it { expect((Field.new(1,1).live!(0,0))[0,0]).to eq :alive}
  it { expect((Field.new(2,2).live!(1,1))[0,0]).to eq :dead}
  it { expect((Field.new(3,3).live!(1,1).die!(1,1))[1,1]).to eq :dead}
  it { expect(Field.new(3,3).live!(1,1).next[1,1]).to eq :dead}
  
  context 'tree alive in a row' do
    subject(:field) { Field.new(3,3).live!(1,0).live!(1,1).live!(1,2).next }
    it { expect(field[1,1]).to eq :alive }  
    it { expect(field[1,0]).to eq :dead }
    it { expect(field[0,1]).to eq :alive }
  end

  describe '#neighbors' do
    it { expect(Field.new(3,3).neighbors(1,1)).to eq 0 }
    it { expect(Field.new(3,3).live!(0,0).neighbors(1,1)).to eq 1 }
    it { expect(Field.new(3,3).live!(0,1).neighbors(1,1)).to eq 1 }
    it { expect(Field.new(3,3).live!(0,1).live!(2,2).neighbors(0,0)).to eq 1 }
  end

end
