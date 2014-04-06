require 'spec_helper'

describe Resolution do
  describe "submitter" do
    it "it should be able to add a submitter" do
      resolution = FactoryGirl.create(:resolution)
      delegation = FactoryGirl.create(:delegation)

      topic.addDelegate(resolution)
      topic.save

      expect(topic.resolutions).to include(resolution)
    end

  end
end
