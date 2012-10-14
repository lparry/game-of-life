require File.expand_path("../world", __FILE__)
require File.expand_path("../world_printer", __FILE__)
require 'io/wait'

class Game
  def initialize(printer, percentage_filled = 0.5)
    @printer = printer
    @percentage_filled = percentage_filled
  end

  def run
    world = initial_world
    while (true)
      str = @printer.print(world)
      puts "\e[H\e[2J#{str}"
      fork { sleep(0.05) }
      world = world.next_tick
      update_printer(get_char)
      Process.wait
    end
  end

  def update_printer(char)
    case char
    when 'h' #left
      @printer.move_left
    when 'j' #down
      @printer.move_down
    when 'k' #up
      @printer.move_up
    when 'l' #right
      @printer.move_right
    when "-"
      @printer.zoom_out
    when "+"
      @printer.zoom_in
    when 'q'
      exit(0)
    else
      #nothing
    end
  end

  def initial_world
    World.new(@printer.column_range.map do |x|
      @printer.row_range.map do |y|
        Cell.new(x, y) if rand < @percentage_filled
      end
    end.flatten.compact)
  end

  def get_char
    begin
      system("stty raw -echo > /dev/null 2>&1") # turn raw input on
      c = nil
      if $stdin.ready?
        c = $stdin.getc
      end
      c.chr if c
    ensure
      system "stty -raw echo > /dev/null 2>&1" # turn raw input off
    end
  end
end

if $0 == __FILE__
  Game.new(WorldPrinter.new(0, 0, 40, 20), 0.20).run
end
