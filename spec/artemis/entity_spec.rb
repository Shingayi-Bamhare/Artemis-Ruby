require 'spec_helper'

describe Artemis::Entity do
  before do
    @world = double('world',
      entity_manager: "entity_manager stub",
      component_manager: "component_manager stub"
    )
  end

  before :each do
    @entity = Artemis::Entity.new @world
  end

  it "have a random UUID by default" do
    @entity.uuid.should_not be_nil
  end

  context "#reset" do
    it "generate a new uuid" do
      old_uuid = @entity.uuid
      @entity.reset
      @entity.uuid.should_not eq old_uuid
    end

    it "clear system_bits" do
      @entity.system_bits.set Random.rand(@entity.system_bits.size)
      @entity.reset
      @entity.system_bits.should be_clear(*(0..@entity.system_bits.size-1).to_a)
    end

    it "clear component_bits" do
      @entity.component_bits.set Random.rand(@entity.component_bits.size)
      @entity.reset
      @entity.component_bits.should be_clear(*(0..@entity.component_bits.size-1).to_a)
    end
  end

  context "#to_s" do
    it "generate string in format Entity[id]" do
      @entity.to_s.should eq "Entity[#{@entity.id}]"
    end
  end
end
