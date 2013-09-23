module Artemis
  class Bag < Hash
    def add(e, id = nil)
      self[id || e.id] = e
    end

    def add_all(bag)
      self.merge!(bag)
    end

    def remove(e)
      if e.is_a?(Entity)
        !!self.delete(e.id)
      else
        n = self.count
        self.delete_if { |k, v| v == e }
        n != self.count
      end
    end

    def remove_all(bag)
      n = self.count
      self.delete_if { |k, v| !!bag[k] }
      n != self.count
    end

    def contains?(e)
      if e.is_a?(Entity)
        !!self[e.id]
      else
        self.values.include?(e)
      end
    end

    def each_entity
      self.each_value
    end
  end
end
