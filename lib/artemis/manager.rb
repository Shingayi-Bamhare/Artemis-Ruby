module Artemis
  class Manager

    include ClassLevelInheritableAttributes
    inheritable_attributes :world
    @world = World.new

    def added(entity); end
    def changed(entity); end
    def deleted(entity); end
    def disabled(entity); end
    def enabled(entity); end

  end
end
