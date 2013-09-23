require 'spec_helper'

describe Artemis::TagManager do

  it "should work" do
    tm = Artemis::TagManager.new
    tm.entity_by_tag.should == {}

    w = Artemis::World.new
    e1 = Artemis::Entity.new w
    e2 = Artemis::Entity.new w
    t1 = :tag1
    t2 = :tag2

    tm.registered?(t1).should == false
    tm.registered?(t2).should == false
    tm.get_entity(t1).should == nil
    tm.get_entity(t2).should == nil
    tm.get_registered_tags.should == []

    tm.register(t1, e1)
    tm.registered?(t1).should == true
    tm.registered?(t2).should == false
    tm.get_entity(t1).should == e1
    tm.get_entity(t2).should == nil
    tm.get_registered_tags.should == [t1]

    tm.register(t2, e1)
    tm.registered?(t1).should == true
    tm.registered?(t2).should == true
    tm.get_entity(t1).should == e1
    tm.get_entity(t2).should == e1
    tm.get_registered_tags.should == [t1, t2]
    tm.get_entity(t1).should == e1
    tm.get_entity(t2).should == e1

    tm.unregister(t2)
    tm.registered?(t1).should == true
    tm.registered?(t2).should == false
    tm.get_entity(t1).should == e1
    tm.get_entity(t2).should == nil
    tm.get_registered_tags.should == [t1]

    tm.deleted(e1)
    tm.registered?(t1).should == false
    tm.registered?(t2).should == false
    tm.get_entity(t1).should == nil
    tm.get_entity(t2).should == nil
    tm.get_registered_tags.should == []
  end

end