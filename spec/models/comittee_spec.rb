require 'spec_helper'

describe Comittee do
  describe "name" do
    it "should have a name" do
      comittee = FactoryGirl.build(:comittee)
      comittee.name = nil

      comittee.should_not be_valid
    end
  end
end
