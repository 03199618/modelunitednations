require 'spec_helper'

describe CommitteeSession do
  describe "committee" do
    it "should have a committee" do
      session = FactoryGirl.build(:committee_session)
      session.committee = nil
      session.should_not be_valid
    end
  end
end
