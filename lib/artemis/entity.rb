require 'bitset'
require 'securerandom'

module Artemis
  # The entity class. Cannot be instantiated outside the framework, you must
  # create new entities using World.
  class Entity
    attr_reader :world, :id, :uuid, :system_bits, :component_bits

    def initialize(world, id)
      @world = world
      @id = id
      @entity_manager = world.entity_manager
      @component_manager = world.component_manager

      # Init UUID
      @uuid = SecureRandom.uuid

      @system_bits = Bitset.new 8
      @component_bits = Bitset.new 8
    end

    # Make enitty ready for re-use.
    # Will generate a new uuid
    def reset
      @system_bits.clear(*(0..@system_bits.size-1).to_a)
      @component_bits.clear(*(0..@component_bits.size-1).to_a)
      @uuid = SecureRandom.uuid
    end

    def to_s
      "Entity[#{@id}]"
    end

    # Add the component to this entity
    #
    # @param component to be added
    # @param component_type ComponentType corresponds to component
    #
    # @return this entity for chaining
    def add_component(component, component_type = nil)
      raise "#{component.to_s} is not an instance of Artemis::Component" if !component.is_a?(Component)

      component_type = ComponentType.type_for component.class unless component_type

      @component_manager.add_component self, component_type, component
      
      self
    end

    # Removes the component from this entity
    #
    # @param obj can be either the component to be removed or
    # an ComponentType object
    #
    # @return this entity for chaining
    def remove_component(obj)
      component_type = nil
      if obj.is_a? Component
        component_type = ComponentType.type_for obj.class
      elsif obj.is_a? ComponentType
        component_type = obj
      elsif obj.is_a? Class && obj <= Component
        component_type = ComponentType.type_for obj
      end

      if component_type
        @component_manager.remove_component self, component_type
      else
        raise "#{obj.to_s} is neither a Component object nor ComponentType object nor subclass of Component" 
      end

      self
    end
  end
end
