require 'spec_helper'

describe Artemis::EntitySystem do
  it "inherits from EntityObserver" do
    described_class < Artemis::EntityObserver 
  end

  describe "#initialize" do
    it "clone all given aspect's bitsets" do
      @aspect = Artemis::Aspect.new_for_all Artemis::Component
      @system = Artemis::EntitySystem.new @aspect

      [:all, :exclude, :one].each do |bitset|
        bitset = "#{bitset}_set".to_sym
        @system.send(bitset) == @aspect.send(bitset)
      end
    end
  end

end
