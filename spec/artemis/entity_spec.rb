require 'spec_helper'

describe Artemis::Entity do
  before do
    component_manager = double("component_manager",
                               add_component: "add_component",
                               remove_component: "remove_component" )
    @world = double('world',
                   entity_manager: "entity_manager stub",
                   component_manager: component_manager
                   )
  end

  before :each do
    @entity = Artemis::Entity.new @world
  end

  it "have a random UUID by default" do
    @entity.uuid.should_not be_nil
  end

  context "#to_s" do
    it "generate string in format Entity[id]" do
      @entity.to_s.should eq "Entity[#{@entity.id}]"
    end
  end

  context "#add_component" do
    it "only accept Component objects as first argument" do
      expect { @entity.add_component(Array.new) }.to raise_error
      expect { @entity.add_component(Artemis::Component.new) }.to_not raise_error
    end

    it "imply second argument (component type) from first argument if second argument is ommited" do
      component = Artemis::Component.new
      Artemis::ComponentType.should_receive(:type_for).with component.class

      @entity.add_component component
    end

    it "call @component_manager.add_component" do
      component = Artemis::Component.new
      component_type = Artemis::ComponentType.type_for component.class

      @entity.instance_variable_get(:@component_manager).should_receive(:add_component).with @entity, component_type, component 

      @entity.add_component component, component_type 
    end

    it "return itself" do
      @entity.add_component(Artemis::Component.new).should eq @entity
    end
  end

  context "#remove_component" do
    it "only accept Component or ComponentType objects as argument" do
      expect { @entity.remove_component(Array.new) }.to raise_error
      expect { @entity.remove_component(Artemis::Component.new) }.to_not raise_error
      expect { @entity.remove_component(Artemis::ComponentType.type_for Artemis::Component.new.class) }.to_not raise_error
    end

    it "call @component_manager.remove_component" do
      component = Artemis::Component.new
      component_type = Artemis::ComponentType.type_for component.class

      @entity.instance_variable_get(:@component_manager).should_receive(:remove_component).with @entity, component_type

      @entity.remove_component component
    end

    it "return itself" do
      @entity.remove_component(Artemis::Component.new).should eq @entity
    end
  end
  
end
