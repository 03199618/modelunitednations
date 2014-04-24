require 'spec_helper'

describe ComitteeSession do
  describe "comittee" do
    it "should have a comittee" do
      session = FactoryGirl.build(:comittee_session)
      session.comittee = nil
      session.should_not be_valid
    end
  end
end
