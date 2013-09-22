module Artemis
  class EntityManager
     def initialize
        @entities = Array.new 
        @disabled = BitSet.new
     end

     def create_entity_instance
      Entity e 
     end
  end
end
