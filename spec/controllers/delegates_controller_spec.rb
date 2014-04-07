require 'spec_helper'

describe DelegatesController do

  describe "DELETE #destroy" do
    before :each do
      @delegation = FactoryGirl.create(:delegation)
      @delegate = FactoryGirl.create(:delegate, delegation_id: @delegation.id)
      visit delegation_path(@delegation)
      find(".destroy_delegate_#{@delegate.id}").click
    end
    it "responds successfully with an HTTP 200 status code" do

      expect(response).to be_success
      expect(response.status).to eq(200)
      visit delegation_path(@delegation)
      expect { find(".destroy_delegate_#{@delegate.id}")}.to raise_error
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

end
