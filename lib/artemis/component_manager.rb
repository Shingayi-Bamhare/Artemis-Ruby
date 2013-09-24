module Artemis
  class ComponentManager < Manager
    attr_reader :components_by_type, :deleted_entities

    def initialize
      @components_by_type = Bag.new
      @deleted_entities = Bag.new
    end

    def remove_components_of_entity(entity)
      component_bits = entity.component_bits
      i = 0
      component_bits.each do |bit|
        @components_by_type[i][entity.id] = nil if bit
        i += 1
      end

      component_bits.clear(*(0..component_bits.size-1).to_a)
    end

    def add_component(entity, component_type, component)
      components = get_components_by_type component_type
      components[entity.id] = component

      entity.component_bits.set component_type.index
    end

    def remove_component(entity, component_type)
      if entity.component_bits[component_type.index] 
        @components_by_type[component_type.index][entity.id] = nil
        e.component_bits.clear component_type.index
      end
    end

    def get_components_by_type(component_type)
      components = @components_by_type[component_type.index] 

      unless components
        components = Bag.new
        @components_by_type[component_type.index] = components
      end
    end

    def get_component(entity, component_type)
      components = @components_by_type[component_type.index] 
      unless components
        return components[entity.id]
      end
      nil
    end

    def get_components_for(entity, fill_bag)
      raise "implement me" 
    end

    def deleted(entity)
      @deleted_entities.add entity 
    end

    def clean
      @deleted_entities.each do |entity|
        remove_components_of_entity entity
      end
    end

  end
end
