require 'spec_helper'

describe Artemis::Manager do
  before do
    @world = double('world',
                   entity_manager: "entity_manager stub",
                   component_manager: "component_manager stub"
                   )
  end

  it "have same world with sub-classes" do
    Artemis::EntityManager.world.should == Artemis::Manager.world
  end

end