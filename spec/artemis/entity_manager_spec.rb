require 'spec_helper'

describe Artemis::EntityManager do

  it "have same world with Manager" do
    Artemis::EntityManager.world.should == Artemis::Manager.world
    em = Artemis::EntityManager.new
    em.world.should == Artemis::Manager.world
  end

end