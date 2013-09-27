module Artemis
  # A tag class. All components in the system must extend this class.
  class Component
    def removed(entity)
      puts "removed component #{self} from #{entity}" 
    end
  end
end
