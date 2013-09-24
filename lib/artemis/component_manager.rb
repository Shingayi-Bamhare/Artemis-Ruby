module Artemis
  class ComponentManager < Manager

    def initialize
      @components_by_type = Bag.new
      @deleted_entities = Bag.new
    end

    def remove_components_of_entity(entity)
      component_class_indices = entity.component_class_indices

      component_class_indices.each do |index|
        @components_by_type[index][entity.id] = nil
      end

      component_class_indices.clear
    end

    def add_component(entity, component_type, component)
      components = get_components_by_type component_type
      components[entity.id] = component

      entity.component_class_indices << component_type.index
    end

    def remove_component(entity, component_type)
      if entity.component_class_indicies.include? component_type.index
        @components_by_type[component_type.index][entity.id] = nil
        e.component_class_indices.delete component_type.index
      end
    end

    def get_components_by_type(component_type)
      components = @components_by_type[component_type.index] 

      unless components
        components = Bag.new
        @components_by_type[component_type.index] = components
      end

      components
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
