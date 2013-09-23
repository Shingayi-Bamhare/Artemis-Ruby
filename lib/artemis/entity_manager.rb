require 'bitset'

module Artemis
  class EntityManager < Manager

    def initialize
      @entities = Bag.new
      @disabled = Bitset.new 1000
      @active = @added = @created = @deleted = 0
    end

    def create_entity
      e = Entity.new(world)
      @created += 1
      e
    end

    def added(e)
      active += 1
      added += 1
      @entities.add(e)
    end

  end
end
