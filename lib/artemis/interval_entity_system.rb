module Artemis
  # A system that processes entities at a interval in milliseconds.
  # A typical usage would be a collision system or physics system.
  class IntervalEntitySystem < EntitySystem
    attr_accessor :interval, :acc

    def initialize(aspect, interval)
      super(aspect)
      @interval = interval
      @acc = 0
    end

    def check_processing
      @acc += @world.delta
      if @acc >= @interval
        @acc -= @interval
        return true
      end

      false
    end

  end #class
end #module
