require 'spec_helper'

describe WelcomeController do

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

    it "loads all of the conferences into @confrences" do
      conference1, conference2 = FactoryGirl.create(:conference), FactoryGirl.create(:conference)
      get :index

      expect(assigns(:conferences)).to match_array([conference1, conference2])
    end
  end
end
