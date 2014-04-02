require 'spec_helper'

describe Participant do
  describe "participant role" do
    it "it should be able to add a participant role" do
      participant= FactoryGirl.build(:participant)
      participant_role = FactoryGirl.build(:participant_role)
      participant_role.save

      participant.addParticipantRole(participant_role.name)

      expect(participant.participant_roles).to include(participant_role)
    end

    it "it should raise an error on incorrect participant role" do
      participant= FactoryGirl.build(:participant)
      participant_role = FactoryGirl.build(:participant_role)
      participant_role.save

      participant.addParticipantRole("1234h8ofho17h3")

      expect(participant.errors[:base]).to include("Participant '1234h8ofho17h3' role not found.")
    end


  end

  describe "name" do
    it "should return a name without user" do
      participant= FactoryGirl.build(:participant)
      participant_role = FactoryGirl.create(:participant_role)
      participant.addParticipantRole(participant_role.name)

      participant.name.should eq participant_role.name
    end

    it "should return a name with a user" do
      user = FactoryGirl.create(:user)
      participant= FactoryGirl.build(:participant, user_id: user.id)
      participant_role = FactoryGirl.create(:participant_role)
      participant.addParticipantRole(participant_role.name)

      participant.name.should eq user.name
    end
  end

end
