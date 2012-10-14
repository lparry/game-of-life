require File.expand_path("../world", __FILE__)
require File.expand_path("../world_printer", __FILE__)
require File.expand_path("../viewport", __FILE__)
require 'io/wait'

class Game

  attr_writer :initial_world

  def initialize(printer, percentage_filled = 0.5)
    @printer = printer
    @percentage_filled = percentage_filled
  end

  def run
    world = initial_world
    while (true)
      puts "#{clear_screen_char}#{@printer.print(world)}"
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

  private

  def initial_world
    @initial_world ||= World.generate(@printer.visible_pixels, @percentage_filled)
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


  def clear_screen_char
    "\e[H\e[2J"
  end
end

if $0 == __FILE__
  viewport = Viewport.new(0, 0, 80, 60)
  game = Game.new(WorldPrinter.new(viewport))
  game.initial_world = World.generate(Viewport.new(20, 15, 40,30).visible_pixels, 0.20)
  game.run
end
