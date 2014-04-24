require 'spec_helper'

describe GroupRegistration do
  describe "registrations" do
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

    it "should not register the members of the group twice" do
      participant_group = FactoryGirl.create(:participant_group)
      1.upto(3) do
        participant_group.addParticipantGroupMember(FactoryGirl.create(:user))
      end

      conference = FactoryGirl.create(:conference)
      group_registration = FactoryGirl.build(:group_registration, conference_id: conference.id, participant_group_id: participant_group.id)
      group_registration.save
      group_registration.save

      group_registration.registrations.count.should be 3
    end
  end

  describe "withdrawel" do
    before :each do
      participant_group = FactoryGirl.create(:participant_group)
      1.upto(3) do
        participant_group.addParticipantGroupMember(FactoryGirl.create(:user))
      end
      conference = FactoryGirl.create(:conference)
      @group_registration = FactoryGirl.build(:group_registration, conference_id: conference.id, participant_group: participant_group)
      @group_registration.save
      @group_registration.withdraw
    end
    it "should withdraw all registrations as well" do

      @group_registration.registrations.count.should be 3

      @group_registration.registrations.each do |registration|
        puts registration.inspect
        registration.withdrawn.should be true
      end

      @group_registration.withdrawn.should eq true
    end
  end

  describe "status" do
    before :each do
      participant_group = FactoryGirl.create(:participant_group)
      1.upto(3) do
        participant_group.addParticipantGroupMember(FactoryGirl.create(:user))
      end
      conference = FactoryGirl.create(:conference)
      @group_registration = FactoryGirl.build(:group_registration, conference_id: conference.id, participant_group: participant_group)
      @group_registration.save
    end

    describe "it should return its status" do
      it "should be withdrawn" do

        @group_registration.withdraw
        @group_registration.save
        @group_registration.status.should eq "withdrawn"
      end

      it "should be rejected" do

        @group_registration.reject
        @group_registration.save
        @group_registration.status.should eq "rejected"
      end

      it "should be accepted" do

        @group_registration.accept
        @group_registration.save
        @group_registration.status.should eq "accepted"
      end
    end
  end


end
