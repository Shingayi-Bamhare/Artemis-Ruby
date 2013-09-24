module Artemis
  class Bag < Hash

    def add(e, id = nil)
      self[id || e.id] = e
    end

    def remove(e)
      if e.is_a?(Entity)
        self.delete(e.id)
      else
        self.delete_if { |k, v| v == e }
      end
    end

  end
end
