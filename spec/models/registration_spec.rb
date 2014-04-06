require 'spec_helper'

describe Registration do
  describe "conferences" do
    it "should have a conference" do
      registration = FactoryGirl.create(:registration)
      registration.conference = nil
      registration.should_not be_valid
    end
  end

  describe "participant group" do
    it "should have a participant" do
      registration = FactoryGirl.create(:registration)
      registration.participant_group = nil
      registration.should_not be_valid
    end
  end
end
