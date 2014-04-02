require 'spec_helper'

describe Delegation do
  describe "name" do
    it "should have a name" do
      delegation = FactoryGirl.build(:delegation)
      delegation.name = nil

      delegation.should_not be_valid
    end
  end
end
