require 'spec_helper'

describe Artemis::EntityManager do

  it "can have diff worlds" do
    em = Artemis::EntityManager.new
    m = Artemis::Manager.new
    m.world = Artemis::World.new
    em.world = Artemis::World.new
    em.world.should_not == m.world
  end

end