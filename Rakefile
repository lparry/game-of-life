require "rspec/core/rake_task"
require_relative "lib/game"

RSpec::Core::RakeTask.new(:spec)

desc "Run the game of life"
task :run do
  viewport = Viewport.new(0, 0, 80, 60)
  game = Game.new(WorldPrinter.new(viewport))
  game.initial_world = World.generate(Viewport.new(20, 15, 40,30).visible_pixels, 0.20)
  game.run
end

task :default => :spec
