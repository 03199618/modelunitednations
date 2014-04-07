require 'spec_helper'

describe ConferencesController do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the conferences into @conferences" do
      conference1, conference2 = Conference.create!, Conference.create!
      get :index

      expect(assigns(:conferences)).to match_array([conference1, conference1])
    end
  end

  describe "POST #update" do
    before :each do
      conference = FactoryGirl.create(:conference)
      post :conference
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to conference" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before :each do
      conference = FactoryGirl.create(:conference)
      visit edit_user_path(conference)
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end

    it "loads the conference in the @conference" do
      expect(assigns(:conference)).to match(conference)
    end

    it "should have a link to update the user" do
      page.should have_link("Update")
    end
  end

end
