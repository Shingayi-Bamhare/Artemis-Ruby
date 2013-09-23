require 'spec_helper'

describe Artemis::Manager do

  it "have world" do
    w = Artemis::World.new
    m = Artemis::Manager.new
    m.world = w
    m.world.should == w
  end

end