require 'spec_helper'

describe ConferencesController do
  login_user

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
    it "should filter by name" do
      conference1 = FactoryGirl.create(:conference, name: "SWAGMUN")
      conference2 = FactoryGirl.create(:conference, name: "FAGMUN")
      get :index, :search => "SWAG"

      expect(assigns(:conferences)).to match_array([conference1])
    end

    it "should not display not public conferences" do
      conference1 = FactoryGirl.create(:conference, name: "SWAGMUN")
      conference2 = FactoryGirl.create(:conference, name: "FAGMUN", public: false)
      get :index

      expect(assigns(:conferences)).to match_array([conference1])
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :index
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before :each do
      conference = FactoryGirl.build(:conference).attributes
      post 'create', :conference => conference
    end

    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "adds me as the manager" do

      page.should have_content(subject.current_user.name)
    end

    it "redirects_to conference" do
      expect(response).to render_template("show")
    end
  end

  describe "POST #update" do
    before :each do
      @conference = FactoryGirl.create(:conference)
      @attr = { :name => "New name", :acronym => "EPICMUN" }
      put :update, :id => @conference.id, :conference => @attr
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "redirects_to conference" do
      expect(response).to render_template("show")
    end

    it "allows an conference to be updated" do

      @conference.reload
      @conference.name.should == @attr[:name]
      @conference.acronym.should == @attr[:acronym]
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

  describe "DELETE #destroy" do
    before :each do
      @conference = FactoryGirl.create(:conference)
      visit edit_conference_path(@conference)
      click_on "Delete #{@conference.name}"
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
      visit conferences_path(@conference)
      expect { find(@conference.name)}.to raise_error
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

end
