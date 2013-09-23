module Artemis
  # An Aspects is used by systems as a matcher against entities, to check if a system is
  # interested in an entity. Aspects define what sort of component types an entity must
  # possess, or not possess.
  # 
  # This creates an aspect where an entity must possess A and B and C:
  # Aspect.get_aspect_for_all(A.class, B.class, C.class)
  # 
  # This creates an aspect where an entity must possess A and B and C, but must not possess U or V.
  # Aspect.get_aspect_for_all(A.class, B.class, C.class).exclude(U.class, V.class)
  # 
  # This creates an aspect where an entity must possess A and B and C, but must not possess U or V, but must possess one of X or Y or Z.
  # Aspect.get_aspect_for_all(A.class, B.class, C.class).exclude(U.class, V.class).one(X.class, Y.class, Z.class)
  #
  # You can create and compose aspects in many ways:
  # Aspect.get_empty().one(X.class, Y.class, Z.class).all(A.class, B.class, C.class).exclude(U.class, V.class)
  # is the same as:
  # Aspect.get_aspect_for_all(A.class, B.class, C.class).exclude(U.class, V.class).one(X.class, Y.class, Z.class)
  class Aspect
    attr_reader :all_set, :exclusion_set, :one_set

    def initialize
      @all_set = Bitset.new 8
      @exclusion_set = Bitset.new 8
      @one_set = Bitset.new 8
    end  


  end
end
