require 'spec_helper'

describe Artemis::Aspect do
  it "init all_set, exclusion_set and one_set" do
    aspect = Artemis::Aspect.new

    aspect.all_set.should be_a Bitset
    aspect.exclusion_set.should be_a Bitset
    aspect.one_set.should be_a Bitset
  end

end
