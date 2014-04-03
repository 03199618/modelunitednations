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
end
