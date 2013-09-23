require 'spec_helper'

describe Artemis::EntitySystem do
  it "inherits from EntityObserver" do
    described_class < Artemis::EntityObserver 
  end

  describe "#initialize" do
    it "clone all given aspect's bitsets" do
      @aspect = Artemis::Aspect.new_for_all Artemis::Component
      @system = Artemis::EntitySystem.new @aspect

      @system.all_set.should == @aspect.all_set
      @system.exclude_set.should == @aspect.exclude_set
      @system.one_set.should == @aspect.one_set
    end
  end

end
