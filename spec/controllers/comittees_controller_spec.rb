require 'spec_helper'

describe ComitteesController do

  describe "GET #show'" do
    before :each do
      @comittee = FactoryGirl.create(:comittee)
      get 'show', id: @comittee.id
    end
    it "returns http success" do

      response.should be_success
    end

    it "shoud assign the comittee" do

      expect(assigns(:comittee)).to match(@comittee)
    end

    it "renders new" do
      expect(response).to render_template("show")
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "Get #new" do
    before :each do
      @conference = FactoryGirl.create(:conference)
      get 'new', :conference_id  => @conference.id
    end

    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "shoud assign the conference" do

      expect(assigns(:conference)).to match(@conference)
    end

    it "renders new" do
      expect(response).to render_template("new")
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
