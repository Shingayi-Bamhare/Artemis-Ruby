require 'bitset'
require 'securerandom'

module Artemis
  # The entity class. Cannot be instantiated outside the framework, you must
  # create new entities using World.
  class Entity
    attr_reader :world, :id, :uuid, :system_bits, :component_bits

    def initialize(world, id)
      @world = world
      @id = id
      @entity_manager = world.entity_manager
      @component_manager = world.component_manager

      # Init UUID
      @uuid = SecureRandom.uuid

      @system_bits = Bitset.new 8
      @component_bits = Bitset.new 8
    end

    # Make enitty ready for re-use.
    # Will generate a new uuid
    def reset
      @system_bits.clear(*(0..@system_bits.size-1).to_a)
      @component_bits.clear(*(0..@component_bits.size-1).to_a)
      @uuid = SecureRandom.uuid
    end

    def to_s
      "Entity[#{@id}]"
    end
  end
end
