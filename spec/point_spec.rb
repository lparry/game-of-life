require File.expand_path('../../lib/point',__FILE__)
describe Point do
  it "should know if another cell is a neighbor" do
    a = Point(1, 1)
    b = Point(2, 2)
    c = Point(2, 3)

    expect(a.next_to?(b)).to be true
    expect(b.next_to?(a)).to be true
    expect(a.next_to?(c)).to be false
    expect(a.next_to?(a)).to be false

  end

  it "should know if its the same point" do
    expect(Point(1,2)).to eq(Point(1,2))

    expect(Point(1,2)).to_not eq(Point(1,3))
  end

  it "should would with array.uniq" do
    expect([Point(1,2), Point(1,2)].uniq.length).to eq(1)
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
      expect((tr <=> tr)).to eq(0)
      expect((tr <=> tc)).to eq(-1)
      expect((tc <=> tr)).to eq(1)

      expect((tr <=> mr)).to eq(-1)
      expect((mr <=> tr)).to eq(1)

    expect([tr, tc, tl, mr, mc, ml, br, bc, bl].shuffle.sort).to eq(
     [tr, tc, tl, mr, mc, ml, br, bc, bl])


    end
  end

end
