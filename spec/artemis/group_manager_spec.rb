require 'spec_helper'

describe Artemis::GroupManager do

  it 'should work' do
    gm = Artemis::GroupManager.new
    gm.entities_by_group.should == {}
    gm.groups_by_entity.should == {}

    w = Artemis::World.new
    e1 = Artemis::Entity.new w
    e2 = Artemis::Entity.new w
    g1 = :group1
    g2 = :group2

    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == false
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == []
    gm.get_entities(g2).should == []
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == []

    gm.add(e1, g1)
    gm.any_group?(e1).should == true
    gm.any_group?(e2).should == false
    gm.in_group?(e1, g1).should == true
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == [e1]
    gm.get_entities(g2).should == []
    gm.get_groups(e1).should == [g1]
    gm.get_groups(e2).should == []

    gm.add(e1, g2)
    gm.any_group?(e1).should == true
    gm.any_group?(e2).should == false
    gm.in_group?(e1, g1).should == true
    gm.in_group?(e1, g2).should == true
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == [e1]
    gm.get_entities(g2).should == [e1]
    gm.get_groups(e1).should == [g1, g2]
    gm.get_groups(e2).should == []

    gm.add(e2, g1)
    gm.any_group?(e1).should == true
    gm.any_group?(e2).should == true
    gm.in_group?(e1, g1).should == true
    gm.in_group?(e1, g2).should == true
    gm.in_group?(e2, g1).should == true
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == [e1, e2]
    gm.get_entities(g2).should == [e1]
    gm.get_groups(e1).should == [g1, g2]
    gm.get_groups(e2).should == [g1]

    gm.deleted(e1)
    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == true
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == true
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == [e2]
    gm.get_entities(g2).should == []
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == [g1]

    gm.add(e2, g2)
    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == true
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == true
    gm.in_group?(e2, g2).should == true
    gm.get_entities(g1).should == [e2]
    gm.get_entities(g2).should == [e2]
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == [g1, g2]

    gm.remove(e2, g1)
    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == true
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == true
    gm.get_entities(g1).should == []
    gm.get_entities(g2).should == [e2]
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == [g2]

    gm.remove(e2, g2)
    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == false
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == []
    gm.get_entities(g2).should == []
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == []
  
    gm.remove(e2, '')
    gm.any_group?(e1).should == false
    gm.any_group?(e2).should == false
    gm.any_group?(3).should == false
    gm.in_group?(e1, g1).should == false
    gm.in_group?(e1, g2).should == false
    gm.in_group?(e2, g1).should == false
    gm.in_group?(e2, g2).should == false
    gm.get_entities(g1).should == []
    gm.get_entities(g2).should == []
    gm.get_groups(e1).should == []
    gm.get_groups(e2).should == []
  end

end