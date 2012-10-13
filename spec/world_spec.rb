require File.expand_path('../../lib/world',__FILE__)

describe World do
  subject {World.new [Cell.new(1,2), Cell.new(2,3)]}
  it 'has many cells' do
    subject.cells.length.should == 2
  end

  it 'knows what points are worth looking at' do
    subject.important_points.should == [
      Cell.new(1,2).affect_area + Cell.new(2,3).affect_area
    ].flatten.uniq.sort

    subject.important_points.count.should == 14
  end
end


