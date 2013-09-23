module Artemis
  # It all started from a world
  class World
    attr_accessor :delta
    attr_reader :added, :changed, :deleted, :enabled, :disabled

    def initialize
      # a world has many managers
      @managers = {}
      @systems = {}

      @added = Bag.new
      @changed = Bag.new
      @deleted = Bag.new
      @enabled = Bag.new
      @disabled = Bag.new

      # a world must have an entity manager and an component manager
      @em = EntityManager.new
      @cm = ComponentManager.new
      add_manager(@em)
      add_manager(@cm)

      @delta = 1.0 / 60 # 60 frames per second by default
    end

    def entity_manager
      @em
    end

    def component_manager
      @cm
    end

    def add_manager(manager)
      # it can have other manager but only one for each manager type
      manager.world = self
      @managers[manager.class] = manager
    end

    def get_manager(manager_class)
      @managers[manager_class]
    end

    def delete_manager(manager)
      !!@managers.delete(manager.class)
    end
    

    def add_entity(e)
      @added.add(e)
    end

    def changed_entity(e)
      @changed.add(e)
    end

    def delete_entity(e)
      @deleted.add(e)
    end

    def enable(e)
      @enabled.add(e)
    end

    def disable(e)
      @disabled.add(e)
    end

    def create_entity
      @em.create_entity
    end

    def get_entity(entity_id)
      @em.get_entity(entity_id)
    end

    def get_systems
      @systems.values
    end

    def set_system(system, passive = false)
      system.world = self
      system.passive = passive
      @systems[system.class] = system
    end

    def get_system(system_class)
      @systems[system_class]
    end

    def delete_system(system)
      !!systems.delete(system)
    end

    def process
      (@managers.values + @systems.values).each do |observer|
        [:added, :changed, :deleted, :enabled, :disabled].each do |method_name|
          # puts method_name
          # puts self.send(method_name).values
          self.send(method_name).each_value do |entity|
            # puts "---------\n#{observer}\n-------"
            # puts "---------\n#{entity}\n-------"
            observer.send(method_name, entity)
          end
        end
      end
    end

    def to_s
      'Welcome to a new world!'
    end
  end
end
