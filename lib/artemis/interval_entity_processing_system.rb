module Artemis
  # If you need to process entities at a certain interval then use this.
  # A typical usage would be to regenerate ammo or health at certain intervals, no need
  # to do that every game loop, but perhaps every 100 ms. or every second.
  class IntervalProcessingEntitySystem < IntervalEntitySystem
    def process_entities(entities)
      entities.each { |entity| process_entity entity }
    end
  end #class
end #module
