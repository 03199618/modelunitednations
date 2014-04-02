require 'spec_helper'

describe Delegate do
  describe "associations" do
    it "should belong to a delegation" do
      delegate = FactoryGirl.build(:delegate)
      delegate.delegation_id = nil

      delegate.should_not be_valid
    end
  end

  describe "ambassador" do
    it "should be able to return its ambassador status" do
      delegation = FactoryGirl.create(:delegation)
      delegate = FactoryGirl.create(:delegate, delegation_id: delegation.id)

      delegation.ambassador = delegate

      delegate.ambassador?.should be true

      delegation = FactoryGirl.create(:delegation)
      delegate = FactoryGirl.create(:delegate, delegation_id: delegation.id)

      delegate.ambassador?.should be false
    end
  end
end
