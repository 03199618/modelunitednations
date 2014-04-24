require 'spec_helper'

describe CommitteeMember do
  describe "role" do
    it "it should be able to add a  role" do
      member = FactoryGirl.build(:committee_member)
      role = FactoryGirl.create(:committee_role)

      member.addRole(role.name)

      expect(member.committee_roles).to include(role)
    end

    it "it should raise an error on incorrect role" do
      member = FactoryGirl.build(:committee_member)
      role = FactoryGirl.create(:committee_role)

      member.addRole("hkshdkfjh")

      expect(member.errors[:base]).to include("Committee role 'hkshdkfjh' not found.")
    end


  end
end
