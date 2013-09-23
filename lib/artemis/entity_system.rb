module Artemis
  class EntitySystem < EntityObserver
    attr_reader :world, :active_entities, :aspect, :system_index
    attr_reader :all_set, :exclude_set, :one_set
    attr_accessor :passive
    attr_reader :dummy

    # Creates an entity system that uses the specified aspect as a matcher against entities.
    # @param aspect to match against entities
    def initialize(aspect)
      @active_entities = Bag.new

      @aspect = aspect
      @all_set = aspect.all_set
      @exclude_set = aspect.exclude_set
      @one_set = aspect.one_set

      @system_index = SystemIndexManager.index_for self.class

      # This system can't possibly be interested in any entity, so it must be "dummy"
      @dummy = @all_set.cardinality == 0 && @one_set.cardinality == 0
    end

    # Called before processing of entities begins
    def pre_process_entities
    end

    def process
      if check_processing
        pre_process_entities
        process_entities @active_entities
        post_process_entities
      end
    end

    # Called after the processing of entities ends
    def post_process_entities 
    end

    # Any implementing entity system must implement this method and the logic
    # to process the given entities of the system.
    # 
    # @param entities the entities this system contains.
    def process_entities(entities)
      raise "implement me in subclass"
    end

    # Check if this system can process
    #
    # @return true if the system should be processed, false if not.
    def check_processing
      raise "implement me in subclass"
    end

    # Called if the system has received a entity it is interested in, e.g. created or a component was added to it.
    # @param e the entity that was added to this system.
    #
    def inserted(entity); end

    # Called if a entity was removed from this system, e.g. deleted or had one of it's components removed.
    #
    # @param e the entity that was removed from this system.
    def removed(entity); end

    # Will check if the entity is of interest to this system.
    #
    # @param e entity to check
    def check(entity)
      return if @dummy

      interested = true # possibly interested, let's try to prove it wrong.

      component_bits = e.component_bits 
      # Check if the entity possesses ALL of the components defined in the aspect
      if (@all_set.cardinality != 0)  
        i = 0
        @all_set.each do |bit|
          if (bit && !component_bits[i])
            interested = false
            break
          end
          i += 1
        end
      end

      # Check if the entity possesses ANY of the exclusion components, if it does then the system is not interested.
      if @exclude_set.cardinality != 0 && interested
        interested = ((@exclude_set & component_bits).cardinality != 0)
      end  

      # Check if the entity possesses ANY of the components in the oneSet. If so, the system is interested.
      if (@one_set.cardinality != 0)
        interested = (@one_set & component_bits).cardinality != 0
      end

      contains = e.system_bits[@system_index]
      if interested && !contains
        insert_to_system entity
      elsif !interested && contains
        remove_from_system entity
      end
    end

    def remove_from_system(entity)
      @active_entities.remove entity
      entity.system_bits.clear @system_index 
      removed entity
    end

    def insert_to_system(entity)
      @active_entities.add entity
      entity.system_bits.set @system_index
      inserted entity 
    end

    def added(entity)
      check entity 
    end

    def changed(entity)
      check entity 
    end

    def deleted(entity)
      remove_from_system entity if entity.system_bits[@system_index]
    end

    def disabled(entity)
      deleted entity 
    end

    def enabled(entity)
      check entity
    end
  end

  # Used to generate a unique bit for each system.
  # Only used internally in EntitySystem.
  class SystemIndexManager
    @@next_index = 0
    @@indices = Hash.new

    def self.index_for(klass)
      index = @@indices[klass] 
      unless index
        index = @@next_index
        @@next_index += 1

        @@indices[klass] = index
      end
      index
    end
  end


end
