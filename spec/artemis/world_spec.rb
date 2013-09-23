require 'spec_helper'

describe Artemis::World do

  context 'it all started by creating a new world, and it' do
    before :all do
      @w = Artemis::World.new
      @tm = Artemis::TagManager.new
    end

    it 'must have an entity manager' do
      @w.entity_manager.is_a?(Artemis::EntityManager).should == true
    end

    it 'must have a component manager' do
      @w.component_manager.is_a?(Artemis::ComponentManager).should == true
    end

    it 'should support 60 frames per second' do
      @w.delta.should == 1.0 / 60
    end

    it 'newly added manager should belong to this world' do
      @w.add_manager(@tm)
      @tm.world.should == @w
    end

    it "should get manager from it's class name" do
      @w.add_manager(@tm)
      @w.get_manager(Artemis::TagManager).should == @tm
    end

    it 'can delete an added manager' do
      @w.add_manager(@tm)
      @w.delete_manager(@tm).should == true
      @w.get_manager(Artemis::TagManager).should == nil
      @w.delete_manager(@tm).should == false
    end

    it 'can process observers (managers, systems) with entities' do
      @w.add_manager(@tm)
      e1 = @w.create_entity
      @w.entity_manager.created.should == 1
      e2 = @w.create_entity
      @w.entity_manager.created.should == 2
      
      @w.get_entity(e1.id).should be_nil
      @w.get_entity(e2.id).should be_nil
      @w.entity_manager.should_not be_active(e1.id)
      @w.entity_manager.should_not be_active(e2.id)

      @w.add_entity(e1)
      @w.get_entity(e1.id).should be_nil
      @w.entity_manager.should_not be_active(e1.id)
      @w.delete_entity(e2)

      @w.process
      @w.entity_manager.active.should == 0
      @w.entity_manager.deleted.should == 1
    end
  end

end