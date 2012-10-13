require File.expand_path("../world", __FILE__)
require File.expand_path("../world_printer", __FILE__)

class Game
  def initialize(printer, percentage_filled = 0.5)
    @printer = printer
    @percentage_filled = percentage_filled
  end

  def run
    world = initial_world
    while (true)
      str = @printer.print(world)
      puts "\e[H\e[2J"
      puts str
      sleep(0.10)
      world = world.next_tick
    end
  end

  def initial_world
    World.new(@printer.column_range.map do |x|
      @printer.row_range.map do |y|
        Cell.new(x, y) if rand > @percentage_filled
      end
    end.flatten.compact)
  end
end

if $0 == __FILE__
  Game.new(WorldPrinter.new(0, 0, 40, 20)).run
end