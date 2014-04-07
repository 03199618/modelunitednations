require 'spec_helper'

describe UsersController do
  describe "POST #update" do
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

  describe "GET #edit" do
    before :each do
      @user = FactoryGirl.create(:user)
      visit edit_user_path(@user)
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end

    it "loads the user in the @user" do
      expect(assigns(:user)).to match(@user)
    end

    it "should have a link to update the user" do
      page.should have_link("Update")
    end
  end
end
