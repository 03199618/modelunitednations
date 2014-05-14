require 'spec_helper'

describe Announcement do
  subject(:announcement) { FactoryGirl.create(:announcement)}

  describe "attributes" do
    it { should respond_to :title}
    it { should respond_to :content}

    before { announcement.title = nil}
    it "should require a title" do

      should_not be_valid
    end

    before { announcement.content = nil}
    it "should require a content" do

      should_not be_valid
    end
  end
end
