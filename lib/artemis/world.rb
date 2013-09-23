module Artemis
  # It all started from a world
  class World
    attr_accessor :entity_manager, :component_manager, :delta

    def initialize
      # a world has many managers
      @managers = {}
      systems = {}

      added = Bag.new
      changed = Bag.new
      deleted = Bag.new
      enable = Bag.new
      disable = Bag.new

      # a world must have an entity manager and an component manager
      @em = EntityManager.new
      @cm = ComponentManager.new
      add_manager(@em)
      add_manager(@cm)

      @delta = 0.0
    end

    def add_manager(manager)
      # it can have other manager but only one for each manager type
      manager.world = self
      @managers[manager.class] = manager
    end

    def entity_manager
      @em
    end

    def component_manager
      @cm
    end


    
    def to_s
      'Welcome to a new world!'
    end
  end
end
