require 'spec_helper'

describe Resolution do
  describe "submitter" do
    it "it should be able to add a submitter" do
      resolution = FactoryGirl.create(:resolution)
      delegate = FactoryGirl.create(:delegate)

      resolution.addSubmitter(delegate)
      resolution.save

      expect(resolution.submitters).to include(delegate)
    end

  end
end
