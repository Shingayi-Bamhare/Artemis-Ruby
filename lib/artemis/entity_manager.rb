module Artemis
  class EntityManager < Manager

    attr_accessor :entities, :disabled, :active, :added, :created, :deleted

    def initialize
      @entities = Bag.new
      @disabled = {}
      @active = @added = @created = @deleted = 0
    end

    def create_entity
      e = Entity.new(world)
      @created += 1
      e
    end

    def add(e)
      @active += 1
      @added += 1
      @entities.add(e)
    end

    def disable(e)
      @disabled[e.id] = true
    end

    def enable(e)
      !!@disabled.delete(e.id)
    end

    def delete(e)
      @entities.remove(e)
      @disabled.delete(e.id)
      @active -= 1
      @deleted += 1
    end

    def active?(entity_id)
      !!@entities[entity_id]
    end

    def enable?(entity_id)
      !disabled[entity_id]
    end

    def get_entity(entity_id)
      @entities[entity_id]
    end
  end
end
