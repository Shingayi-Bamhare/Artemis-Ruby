require 'spec_helper'

describe Artemis::Bag do
  before do
    @world = double('world',
      entity_manager: "entity_manager stub",
      component_manager: "component_manager stub"
    )
  end

  it "work as exepected" do
    b = Artemis::Bag.new
    b.size.should == 0

    s = 'abc'
    e = Artemis::Entity.new(@world)

    b.add(s, 1)
    b.add(e)

    b.size.should == 2
    b.should be_contains(s)
    b.should be_contains(e)

    b.each_entity.to_a.should == [s, e]

    b.remove(3).should == false
    b.remove(s).should == true
    b.should == {e.id => e}

    b1 = Artemis::Bag.new
    b1.add(s, 1)
    b1.add(5, 10)
    
    b.add_all(b1)
    b.values.should == [e, s, 5]

    b.remove_all(b1)
    b.should == {e.id => e}
end

end