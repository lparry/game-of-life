require File.expand_path("../../lib/world_printer", __FILE__)
require File.expand_path("../../lib/viewport", __FILE__)

describe WorldPrinter do
  let(:start_x) { 0 }
  let(:start_y) { 0 }
  let(:width)   { 4 }
  let(:height)  { 5 }
  let(:viewport) { Viewport.new(start_x, start_y, width, height) }
  let(:world)   { World.new([Cell.new(1,2), Cell.new(1,3), Cell.new(1,4)]) }
  subject{ WorldPrinter.new(viewport) }

  it "should calculate a row" do
    expect(subject.render_row(world, 3)).to eq([false, true, false, false])
  end

  it "should make a pretty string" do
    expect(subject.print(world)).to eq([
      "    ",
      "    ",
      " x  ",
      " x  ",
      " x  ",
    ].join("\n"))
  end

  it "should calculate the world" do
    expect(subject.render(world)).to eq([
      [false, false, false, false],
      [false, false, false, false],
      [false, true, false, false],
      [false, true, false, false],
      [false, true, false, false]
    ])
  end

end
