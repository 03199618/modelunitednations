require 'spec_helper'

describe Conference do
  describe "manager" do
    it "it should be able to add a manager" do
      conference = FactoryGirl.create(:conference)
      user = FactoryGirl.create(:user)

      conference.addManager(user)

      expect(conference.managers.pluck(:id)).to include(user.id)
    end

    it "it should return all managers" do
      conference = FactoryGirl.create(:conference)
      manager1 = FactoryGirl.create(:user)
      manager2 = FactoryGirl.create(:user)

      conference.addManager(manager1)
      conference.addManager(manager2)


      expect(conference.managers.pluck(:id)).to eq([manager1.id, manager2.id])
    end


  end

  describe "delegate" do
    it "it should be able to add a delegate" do
      conference = FactoryGirl.create(:conference)
      user = FactoryGirl.create(:user)

      conference.addDelegate(user)

      expect(conference.delegates.pluck(:id)).to include(user.id)
    end

    it "it should return all deleagtes" do
      conference = FactoryGirl.create(:conference)
      delegate1 = FactoryGirl.create(:user)
      delegate2 = FactoryGirl.create(:user)

      conference.addDelegate(delegate1)
      conference.addDelegate(delegate2)

      expect(conference.delegates.pluck(:id)).to eq([delegate1.id, delegate2.id])
    end


  end


  describe "name" do
    it "should require a name" do
      conference = FactoryGirl.build(:conference)
      conference.name = nil
      conference.should_not be_valid
    end

    it "should return its name on missing acronym" do
      conference = FactoryGirl.build(:conference)
      conference.acronym = nil
      conference.acronym.should eq conference.name
    end
  end
end
