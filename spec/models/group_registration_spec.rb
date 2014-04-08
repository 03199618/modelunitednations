require 'spec_helper'

describe GroupRegistration do
  describe "registraions" do
    it "should register the members of the group" do
      participant_group = FactoryGirl.create(:participant_group)
      1.upto(3) do
        participant_group.addParticipantGroupMember(FactoryGirl.create(:user))
      end

      conference = FactoryGirl.create(:conference)
      group_registration = FactoryGirl.build(:group_registration, conference_id: conference.id, participant_group_id: participant_group.id)
      group_registration.save

      group_registration.registrations.count.should be 3
    end
  end
end
