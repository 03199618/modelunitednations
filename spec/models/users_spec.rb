require 'spec_helper'

describe User do
  describe "intro" do
    it "it properly handle the intro boolean" do
      user = FactoryGirl.create(:user)

      user.intro

      expect(user.intro).to be false
    end

  end

  describe "completeness" do
    it "it should return a profile completeness" do
      user = FactoryGirl.create(:user)
      expect(user.completeness).to eq 100
    end

    it "it should return a profile incompleteness" do
      user = FactoryGirl.create(:user)
      user.surname = nil
      user.save
      expect(user.completeness).to eq 75
    end

  end

  describe "familiartiy" do
    it "it should return common conferences" do
      user = FactoryGirl.create(:user)
      familiar_user = FactoryGirl.create(:user)

      conference = FactoryGirl.create(:conference)
      conference.addParticipant(user)
      conference.addParticipant(familiar_user)

      user.common_conferences(familiar_user).should eq [conference]
      user.common_conferences(familiar_user).any?.should eq true
    end

  end
end
