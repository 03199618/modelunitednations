require 'spec_helper'

describe Delegation do
  describe "name" do
    it "should have a name" do
      delegation = FactoryGirl.build(:delegation)
      delegation.name = nil

      delegation.should_not be_valid
    end
  end

  describe "conference" do
    it "should have a conference" do
      delegation = FactoryGirl.build(:delegation)
      delegation.conference = nil
      delegation.should_not be_valid
    end
  end
end
