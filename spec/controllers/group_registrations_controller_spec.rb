require 'spec_helper'

describe GroupRegistrationsController do
  login_user
  describe "PUT #withdraw" do
    before :each do
      @registration = FactoryGirl.create(:group_registration)
      put :withdraw, :id => @registration.id
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to registration" do
      expect(response).to render_template("show")
    end

    it "does not any more allow a withdrawel" do

      page.should_not have_selector("input[type=submit][value='Withdraw']")
    end
  end

  describe "PUT #accept" do
    before :each do
      @conference = FactoryGirl.create(:conference)
      @conference.addManager(subject.current_user)
      @registration = FactoryGirl.create(:group_registration, conference: @conference)
      put :accept, :id => @registration.id
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to registration" do
      expect(response).to render_template("show")
    end

    it "does not any more allow a withdrawel" do
    end
  end

  describe "GET #new" do
    before :each do
      @group_managing = FactoryGirl.create(:participant_group)
      @group_attending = FactoryGirl.create(:participant_group)
      @group_managing.addManager(subject.current_user)
      @group_attending.addParticipantGroupMember(subject.current_user)
      get :new, conference_id: FactoryGirl.create(:conference).id
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to registration" do
      expect(response).to render_template("new")
    end

    it "loads only the groups I manage" do

      assigns(:participant_groups).should_not be_empty
      expect(assigns(:participant_groups)).to match_array([@group_managing])

    end
  end
end
