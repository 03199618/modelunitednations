require 'spec_helper'

describe ParticipantGroupsController do
  login_user
  describe "GET #join" do
    before :each do

      participant_group = FactoryGirl.create(:participant_group)
      visit join_participant_group_path(id: participant_group.id, key:Digest::MD5.hexdigest(participant_group.created_at.to_s+subject.current_user.email))
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "should redirect me to the group" do
      page.should have_content(participant_group.name)
      page.should have_content("joined")
    end
  end

  describe "GET #invite" do
    it "responds successfully with an HTTP 200 status code" do

      participant_group = FactoryGirl.create(:participant_group)
      visit invite_participant_group_path(id: participant_group.id, email: "mail@jakob-zeitler.de")
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "should give me the right key" do

      participant_group = FactoryGirl.create(:participant_group)
      visit invite_participant_group_path(id: participant_group.id, email: "mail@jakob-zeitler.de")
      page.should have_content( key:Digest::MD5.hexdigest(participant_group.created_at.to_s+"mail@jakob-zeitler.de"))
      page.should have_content("key generated")
    end
  end

end
