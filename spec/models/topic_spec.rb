require 'spec_helper'

describe Topic do
  describe "resolution" do
    it "it should be able to add a resolution" do
      topic = FactoryGirl.create(:topic)
      resolution = FactoryGirl.create(:resolution)

      topic.addResolution(resolution)
      topic.save

      expect(topic.resolutions).to include(resolution)
    end

  end
end
