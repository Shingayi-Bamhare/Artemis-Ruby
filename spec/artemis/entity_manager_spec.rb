require 'spec_helper'

describe Artemis::EntityManager do

  it "can have diff worlds" do
    em = Artemis::EntityManager.new
    m = Artemis::Manager.new
    m.world = Artemis::World.new
    em.world = Artemis::World.new
    em.world.should_not == m.world
  end


  it 'should work' do
    em = Artemis::EntityManager.new
    em.disabled.should == {}
    em.active.should == 0
    em.created.should == 0
    em.deleted.should == 0
    em.added.should == 0

    em.world = Artemis::World.new    
    e1 = em.create_entity
    e2 = em.create_entity
    em.get_entity(e1.id).should be_nil
    em.get_entity(e2.id).should be_nil

    em.added(e1)
    em.active.should == 1
    em.created.should == 2
    em.deleted.should == 0
    em.added.should == 1
    em.get_entity(e1.id).should == e1

    em.should be_active(e1.id)
    em.should_not be_active(e2.id)

    em.should be_enable(e1.id)
    em.should be_enable(e2.id)

    em.disabled(e2)
    em.should_not be_enable(e2.id)
    em.active.should == 1
    em.created.should == 2
    em.deleted.should == 0
    em.added.should == 1
    em.get_entity(e1.id).should == e1

    em.added(e2)
    em.active.should == 2
    em.created.should == 2
    em.deleted.should == 0
    em.added.should == 2
    em.get_entity(e1.id).should == e1
    em.get_entity(e2.id).should == e2

    em.deleted(e1)
    em.active.should == 1
    em.created.should == 2
    em.deleted.should == 1
    em.added.should == 2
    em.get_entity(e1.id).should == nil
    em.get_entity(e2.id).should == e2
  end

end