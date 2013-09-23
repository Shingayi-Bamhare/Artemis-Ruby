require 'spec_helper'

describe Artemis::ComponentManager do

  before :each do
    @w = Artemis::World.new
  end

  context 'it all started by creating a new world, and it' do
    it 'must have an entity manager' do
      @w.entity_manager.is_a?(Artemis::EntityManager).should == true
    end

    it 'must have a component manager' do
      @w.component_manager.is_a?(Artemis::ComponentManager).should == true
    end
  end

end