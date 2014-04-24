require 'spec_helper'

describe Comittee do
  describe "name" do
    it "should have a name" do
      comittee = FactoryGirl.build(:comittee)
      comittee.name = nil

      comittee.should_not be_valid
    end
  end

  describe "topics" do
    it "it should be able to add a topic" do
      topic = FactoryGirl.create(:topic)
      comittee = FactoryGirl.create(:comittee)

      comittee.addTopic(topic)

      expect(comittee.topics).to include(topic)
    end
  end
  describe "chair" do
    it "it should be able to add a chair" do
      committee = FactoryGirl.create(:comittee)
      participant = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addChair(participant)

      expect(committee.chairs.pluck(:id)).to include(participant.id)
    end

    it "it should return all managers" do
      committee = FactoryGirl.create(:comittee)
      participant1 = FactoryGirl.create(:participant, conference: committee.conference)
      participant2 = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addChair(participant1)
      committee.addChair(participant2)

      expect(committee.chairs.pluck(:id)).to eq([participant1.id, participant2.id])
    end

    it "it should check a user for chairing" do
      committee = FactoryGirl.create(:comittee)
      chair = FactoryGirl.create(:participant, conference: committee.conference)
      delegate = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addChair(chair)
      committee.addDelegate(delegate)



      expect(committee.chair?(chair)).to be true
      expect(committee.chair?(delegate)).to be false
    end



  end

  describe "delegate" do
    it "it should be able to add a delegate" do
      committee = FactoryGirl.create(:comittee)
      participant = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addDelegate(participant)

      expect(committee.delegates.pluck(:id)).to include(participant.id)
    end

    it "it should return all delegates" do
      committee = FactoryGirl.create(:comittee)
      participant1 = FactoryGirl.create(:participant, conference: committee.conference)
      participant2 = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addDelegate(participant1)
      committee.addDelegate(participant2)

      expect(committee.delegates.pluck(:id)).to eq([participant1.id, participant2.id])
    end

    it "it should check a user for delegation" do
      committee = FactoryGirl.create(:comittee)
      chair = FactoryGirl.create(:participant, conference: committee.conference)
      delegate = FactoryGirl.create(:participant, conference: committee.conference)

      committee.addChair(chair)
      committee.addDelegate(delegate)



      expect(committee.delegate?(chair)).to be false
      expect(committee.delegate?(delegate)).to be true
    end



  end


end
