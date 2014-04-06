require 'spec_helper'

describe ResolutionsController do
  login_user

  describe "GET #index" do
    before :each do
      get :index
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all of the conferences into @conferences" do
      pending "needs better factories"
      resolution1, resolution2 = FactoryGirl.create(:resolution), FactoryGirl.create(:resolution)
      get :index

      expect(assigns(:resolutions)).to match_array([resolution1, resolution2])
    end

    it "should have a link to submit a resolution" do
      get :index
      page.should have_link("+ Submit resolution")
    end
  end

  describe "GET #new" do
    before :each do
      topic = FactoryGirl.create(:topic)
      get :new
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "should show the current topic" do
      visit new_resolution_path(topic_id: topic.id)
      page.should have_content(topic.name)
    end

    it "should have a link to submit a resolution" do
      visit new_resolution_path(topic_id: topic.id)
      page.should have_link("Submit resolution")
    end
  end

  describe "POST #create" do
    before :each do
      topic = FactoryGirl.create(:topic)
      post :create
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to resolution" do
      expect(response).to render_template("")
    end
  end

  describe "GET #show" do
    before :each do
      resolution = FactoryGirl.create(:resolution)
      visit resolution_path(resolution)
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "loads the resolution in the @resolution" do
      pending "needs better factories"
      expect(assigns(:resolution)).to match(resolution)
    end

    it "should have a link to edit the resolution" do
      page.should have_link("Edit")
    end
  end
end
