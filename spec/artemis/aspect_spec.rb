require 'spec_helper'

describe Artemis::Aspect do
  before :each do
    @aspect = Artemis::Aspect.new
  end

  [:all, :exclude, :one].each do |func|
    context "#{func}" do
      it "take a *arg or an array of Component subclasses as argument" do
        expect { @aspect.send func, [1, 2, 3] }.to raise_error

        expect { @aspect.send func, [Artemis::Component, Artemis::Component] }.to_not raise_error
        expect { @aspect.send func, Artemis::Component, Artemis::Component }.to_not raise_error
      end

      it "add component indices into set" do
        class Component1 < Artemis::Component
        end
        class Component2 < Artemis::Component
        end
        class Component3 < Artemis::Component
        end

        @aspect.send func, Component1, Component2
        set = @aspect.send("#{func}_set".to_sym)
        set.include?(Artemis::ComponentType.index_for Component1).should be_true
        set.include?(Artemis::ComponentType.index_for Component2).should be_true
        set.include?(Artemis::ComponentType.index_for Component3).should be_false
      end

      it "return itself" do
        @aspect.send(func, Artemis::Component).should eq @aspect
      end
    end
  end

  ### Factories
  context "#new_for_all, #new_for_one" do
    [:all, :one].each do |func|
      it "create and return a new Aspect object" do
        Artemis::Aspect.send("new_for_#{func}".to_sym, Artemis::Component, Artemis::Component).should be_a Artemis::Aspect
      end
    end
  end

end
