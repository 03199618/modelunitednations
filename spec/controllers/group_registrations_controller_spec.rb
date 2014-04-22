require 'spec_helper'

describe GroupRegistrationsController do
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
end
