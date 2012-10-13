require File.expand_path('../../lib/point',__FILE__)
describe Point do
  it "should know if another cell is a neighbor" do
    a = Point(1, 1)
    b = Point(2, 2)
    c = Point(2, 3)

    a.next_to?(b).should be_true
    b.next_to?(a).should be_true
    a.next_to?(c).should be_false

  end

  it "should know if its the same point" do
    Point(1,2).should == Point(1,2)

    Point(1,2).should_not == Point(1,3)
  end

  it "should would with array.uniq" do
    [Point(1,2), Point(1,2)].uniq.length.should == 1
  end

  context "spaceship" do
    let(:tr){ Point(1,1) }
    let(:tc){ Point(2,1) }
    let(:tl){ Point(3,1) }
    let(:mr){ Point(1,2) }
    let(:mc){ Point(2,2) }
    let(:ml){ Point(3,2) }
    let(:br){ Point(1,3) }
    let(:bc){ Point(2,3) }
    let(:bl){ Point(3,3) }


    it "should sort" do
      (tr <=> tr).should == 0
      (tr <=> tc).should == -1
      (tc <=> tr).should == 1

      (tr <=> mr).should == -1
      (mr <=> tr).should == 1

    [tr, tc, tl, mr, mc, ml, br, bc, bl].shuffle.sort.should ==
     [tr, tc, tl, mr, mc, ml, br, bc, bl]


    end
  end

end
