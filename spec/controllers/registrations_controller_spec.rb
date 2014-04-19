require 'spec_helper'

describe RegistrationsController do
  describe "GET #index" do
    before :each do
      @conference = FactoryGirl.create(:conference)
      @registration = FactoryGirl.create(:registration, conference: @conference)
      get :index, conference_id: @conference.id
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all of the registrations into @registrations" do
      expect(assigns(:registrations)).to match_array([@registration])
    end

    it "assgins the @conference" do
      expect(assigns(:conference)).to match(@conference)
    end
  end
end
