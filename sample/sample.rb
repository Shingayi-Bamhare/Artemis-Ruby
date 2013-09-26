$:.unshift("#{File.dirname(__FILE__)}/../lib")
require 'artemis'
require 'pry'

class Sample
  def run 
    puts "Hello World! This is sample!"
    @world = Artemis::World.new
    @world.add_manager Artemis::TagManager.new
    puts @world.tag_manager

    @world.set_system(MovementSystem.new).setup

    @world.create_entity(PositionComponent.new,
                         VelocityComponent.new,
                         RotationComponent.new).add_to_world

    game_loop
  end

  def game_loop
    now = Time.now
    counter = 1
    loop do
      if Time.now < now + counter
        next
      else
        puts "counting another second ..."
        @world.delta = counter
        @world.process
      end
      counter += 1
      break if counter > 30
    end
  end
end

class PositionComponent < Artemis::Component
  attr_accessor :x, :y
end
class VelocityComponent < Artemis::Component
  attr_accessor :x, :y
end
class RotationComponent < Artemis::Component
  attr_accessor :angle
end

class MovementSystem < Artemis::EntityProcessingSystem
  def initialize
    super(Artemis::Aspect.new_for_all PositionComponent, VelocityComponent, RotationComponent)
  end

  def setup
    @position_mapper = Artemis::ComponentMapper.new(PositionComponent, @world)
  end

  def process_entity(entity)
   puts "process #{entity}" 
  end
end
