require 'spec_helper'

describe Artemis::Bag do
  it "work as exepected" do
    b = Artemis::Bag.new
    b.size.should == 0

    w = Artemis::World.new
    s = 'abc'
    e = Artemis::Entity.new(w)

    b.add(s, 1)
    b.add(e)

    b.size.should == 2
    b.values.should == [s, e]

    b.remove(3).should == b
    b.remove(s).should == b
    b.should == {e.id => e}
    b.remove(e).should == e
  end
end