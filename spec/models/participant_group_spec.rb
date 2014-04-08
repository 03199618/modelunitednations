require 'spec_helper'

describe ParticipantGroup do
  describe "name" do
    it "should have a name" do
      participant_group = FactoryGirl.build(:participant_group)
      participant_group.name = nil

      participant_group.should_not be_valid
    end
  end

  describe "manager" do
    it "it should be able to add a manager" do
      participant_group = FactoryGirl.create(:participant_group)
      user = FactoryGirl.create(:user)


      participant_group.addManager(user)

      expect(participant_group.manager.pluck(:id)).to include(participant_group_member.id)

    end
  end

  describe "member" do
    it "it should be able to add a member" do
      participant_group = FactoryGirl.create(:participant_group)
      user = FactoryGirl.create(:user)

      participant_group.addParticipantGroupMember(user)

      expect(participant_group.manager.pluck(:id)).to include(participant_group_member.id)
    end
  end

  describe "join" do
    it "it should be possible to join the group" do
      participant_group = FactoryGirl.create(:participant_group)
      user = FactoryGirl.create(:user)

      key = Digest::MD5.hexdigest(participant_group.created_at.time.to_i.to_s+user.email)

      expect(participant_group.join(user, key)).to be true

    end

    it "it should not be possible to join the group twice" do
      participant_group = FactoryGirl.create(:participant_group)
      user = FactoryGirl.create(:user)

      key = Digest::MD5.hexdigest(participant_group.created_at.time.to_i.to_s+user.email)

      expect(participant_group.join(user, key)).to be true

      expect(participant_group.join(user, key)).to be false


    end
  end

  describe "key" do
    it "it should be possible to retrieve a key" do
      participant_group = FactoryGirl.create(:participant_group)
      email = "mail@jakob-zeitler.de"

      key = Digest::MD5.hexdigest(participant_group.created_at.time.to_i.to_s+email)

      expect(participant_group.key(email)).to eq key

    end
  end
end
