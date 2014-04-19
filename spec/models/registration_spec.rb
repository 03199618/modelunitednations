require 'spec_helper'

describe Registration do
  describe "conferences" do
    it "should have a conference" do
      registration = FactoryGirl.create(:registration)
      registration.conference = nil
      registration.should_not be_valid
    end
  end

  describe "participant group member" do
    it "should have a participant group member" do
      registration = FactoryGirl.create(:registration)
      registration.participant_group_member_id = nil
      registration.should_not be_valid
    end
  end

  describe "user" do
    it "should have a user" do
      registration = FactoryGirl.create(:registration)
      registration.user_id = nil
      registration.should_not be_valid
    end
  end

  describe "#accept" do
    it "should accept a user" do
      registration = FactoryGirl.create(:registration)
      registration.accept
      expect(registration.conference.participant?(registration.user)).to eq true
    end

    it "should not accept a user that is already participating" do
      registration = FactoryGirl.create(:registration)
      registration.accept #First time
      expect(registration.accept).to eq false #Second time
    end
  end
end
