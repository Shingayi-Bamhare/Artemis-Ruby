module Artemis
  class Manager
    attr_accessor :world

    def added(entity); end
    def changed(entity); end
    def deleted(entity); end
    def disabled(entity); end
    def enabled(entity); end
  end
end
