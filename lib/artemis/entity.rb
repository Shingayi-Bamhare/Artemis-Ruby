module Artemis
  # The entity class. Cannot be instantiated outside the framework, you must
  # create new entities using World.

  class Entity
    attr_reader :world, :uuid, :system_class_indices, :component_class_indices

    BIG_N = 1_000_000
    def gen_uuid
      (Time.now.to_f * BIG_N).to_i * BIG_N + rand(BIG_N)
    end

    def initialize(world)
      @world = world
      @entity_manager = world.entity_manager
      @component_manager = world.component_manager
      @system_class_indices = Array.new
      @component_class_indices = Array.new
      @uuid = gen_uuid
    end

    # Make enitty ready for re-use.
    # Will generate a new uuid
    def reset
      @system_class_indices.clear
      @component_classes_indices.clear
      @uuid = gen_uuid
    end

    def id
      @uuid
    end

    def to_s
      "Entity[#{id}]"
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

    def add_components(*components)
      components.each do |component|
        add_component component
      end 
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

    # Checks if the entity has been added to the world and has not been deleted from it.
    # If the entity has been disabled this will still return true.
    #
    # @return if it's active
    def is_active 
      @entity_manager.is_active? id
    end


    # Will check if the entity is enabled in the world.
    # By default all entities that are added to world are enabled,
    # this will only return false if an entity has been explicitly disabled.
    # 
    # @return if it's enabled
    def is_enabled
      @entity_manager.is_enabled? id
    end

    # This is the preferred method to use when retrieving a component from a
    # entity. It will provide good performance.
    # But the recommended way to retrieve components from an entity is using
    # the ComponentMapper.
    # 
    # @param type in order to retrieve the component fast you must provide a
    #             ComponentType instance for the expected component.
    # @return
    def get_component(obj)
      component_type = obj if obj.is_a? ComponentType
      component_type = ComponentType.type_for obj if obj.is_a?(Class) && obj <= Component

      if component_type
        @component_manager.get_component self, component_type 
      else
        raise "#{obj.to_s} is neither a ComponentType object nor an Component subclass"
      end
    end

    def get_components
      raise "implement me"
    end
      
    # Refresh all changes to components for this entity. After adding or
    # removing components, you must call this method. It will update all
    # relevant systems. It is typical to call this after adding components to a
    # newly created entity.
    def add_to_world
      @world.add_entity self
    end

	  # This entity has changed, a component added or deleted.
    def change_in_world
      @world.changed_entity self  
    end

    # Delete this entity from the world.
    def delete_from_world
      @world.delete_entity self
    end

    # (Re)enable the entity in the world, after it having being disabled.
    # Won't do anything unless it was already disabled.
    def enable
      @world.enable self
    end

    # Disable the entity from being processed. Won't delete it, it will
    # continue to exist but won't get processed.
    def disable
      @world.disable self
    end

  end
end
