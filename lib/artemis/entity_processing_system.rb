module Artemis
  # A typical entity system. Use this when you need to process entities possessing the
  # provided component types.
  class EntityProcessingSystem < EntitySystem
    def process_entities(entities)
      #puts "------------ process_entities #{self}"
      entities.each { |entity| process_entity entity }
    end

    def check_processing
      true
    end
  end
end
