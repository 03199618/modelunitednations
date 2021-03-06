require 'spec_helper'
require "cancan/matchers"

describe User, "abilities" do
  subject(:ability) { Ability.new(user) }
  let(:user) { FactoryGirl.create(:user) }

  describe "conferences" do
    let(:guest) { FactoryGirl.build(:user) }

    let(:manager) { FactoryGirl.create(:user) }
    let(:delegate) { FactoryGirl.create(:user) }
    let(:conference) { FactoryGirl.create(:conference)}
    let(:registration) { FactoryGirl.create(:registration)}

    context "when manager" do
      before { conference.addManager(manager) }

      subject(:ability) { Ability.new(manager) }

      it { should be_able_to(:update, conference) }

      context "registration" do
        let(:registration) { FactoryGirl.create(:registration, conference: conference, user_id: manager.id)}
        it { should be_able_to(:reject, registration) }
        it { should be_able_to(:read, registration) }
        it { should be_able_to(:accept, registration) }
      end

      context "participants" do
        it { should be_able_to(:index_participants, conference) }
      end

      context "group registration" do
        let(:group_registration) { FactoryGirl.create(:group_registration, conference: conference)}
        it { should be_able_to(:reject, group_registration) }
        it { should be_able_to(:read, group_registration) }
        it { should be_able_to(:accept, group_registration) }

        context "withdrawn" do
          let(:group_registration) { FactoryGirl.create(:group_registration, conference: conference, withdrawn: true)}
          it { should_not be_able_to(:reject, group_registration) }
          it { should be_able_to(:read, group_registration) }
          it { should_not be_able_to(:accept, group_registration) }
        end

        context "accepted" do
          let(:group_registration) { FactoryGirl.create(:group_registration, conference: conference, accepted: true)}
          it { should_not be_able_to(:reject, group_registration) }
          it { should be_able_to(:read, group_registration) }
          it { should_not be_able_to(:accept, group_registration) }
        end
      end
      context "events" do

        it { should be_able_to(:create, conference.timetable.events.new) }

      end

      context "committees" do
        let(:committee) { FactoryGirl.create(:committee, conference: conference)}
        it { should be_able_to(:create, conference.committees.new) }
        it { should be_able_to(:read, committee) }
        it { should be_able_to(:update, committee) }
        it { should be_able_to(:destroy, committee) }
      end

      context "delegations" do
        let(:delegation) { FactoryGirl.create(:delegation, conference: conference)}
        it { should be_able_to(:create, conference.delegations.new) }
        it { should be_able_to(:read, delegation) }
        it { should be_able_to(:update, delegation) }
        it { should be_able_to(:destroy, delegation) }
      end

      context "committee_member" do
        let(:delegate) { FactoryGirl.create(:delegation, conference: conference)}
        it { should be_able_to(:create, conference.delegations.new) }
        it { should be_able_to(:read, delegation) }
        it { should be_able_to(:update, delegation) }
        it { should be_able_to(:destroy, delegation) }
      end

      context "committee sessions" do
        let(:committee) { FactoryGirl.create(:committee, conference: conference)}
        let(:committee_session) { FactoryGirl.create(:committee_session, committee: committee)}
        it { should be_able_to(:create, committee.committee_sessions.new) }
      end
    end
    context "when delegate" do
      before { conference.addDelegate(delegate) }
      subject(:ability) { Ability.new(delegate) }
      it { should be_able_to(:show, conference) }

      context "registration" do
        let(:registration) { FactoryGirl.create(:registration, conference: conference, user_id: delegate.id)}
        it { should_not be_able_to(:reject, registration) }
        it { should be_able_to(:show, registration) }
        it { should_not be_able_to(:accept, registration) }
      end

      context "committees" do
        let(:committee) { FactoryGirl.create(:committee, conference: conference)}
        it { should_not be_able_to(:create, conference.committees.new) }
        it { should be_able_to(:read, committee) }
        it { should_not be_able_to(:update, committee) }
        it { should_not be_able_to(:destroy, committee) }
        it { should_not be_able_to(:destroy, committee) }
      end

      context "committee sessions" do
        let(:committee) { FactoryGirl.create(:committee, conference: conference)}
        let(:committee_session) { FactoryGirl.create(:committee_session, committee: committee)}
        it { should_not be_able_to(:create, committee.committee_sessions.new) }
      end
    end
    context "not public" do
      let(:conference) { FactoryGirl.create(:conference, public: false)}

      context "when delegate" do
        before { conference.addDelegate(delegate) }
        subject(:ability) { Ability.new(delegate) }
        it { should be_able_to(:show, conference) }
      end

      context "when manager" do
        before { conference.addManager(manager) }
        subject(:ability) { Ability.new(manager) }
        it { should be_able_to(:show, conference) }
      end

      context "when non participant" do
        subject(:ability) { Ability.new(user) }
        it { should_not be_able_to(:read, conference) }
      end

      context "when guest" do
        subject(:ability) { Ability.new(guest) }
        it { should_not be_able_to(:read, conference) }
      end

      context "committees" do
        let(:committee) { FactoryGirl.create(:committee, conference: conference)}
        before { conference.addDelegate(delegate) }
        subject(:ability) { Ability.new(delegate) }
        it { should be_able_to(:read, committee) }
        subject(:ability) { Ability.new(guest) }
        it { should_not be_able_to(:read, committee) }
      end

    end

    describe "index" do
      subject(:ability) { Ability.new(nil) }
      it { should be_able_to(:index, conference) }
    end
  end

  describe "participant group" do
    let(:guest) { FactoryGirl.build(:user) }
    let(:user) { FactoryGirl.create(:user) }
    let(:manager) { FactoryGirl.create(:user) }
    let(:member) { FactoryGirl.create(:user) }
    let(:participant_group) { FactoryGirl.create(:participant_group)}

    subject(:ability) { Ability.new(user) }
    it { puts user.inspect}
    it { should be_able_to(:join, participant_group) }
    it { should be_able_to(:new, GroupRegistration) }
    context "when manager" do
      before { participant_group.addManager(manager) }

      subject(:ability) { Ability.new(manager) }

      it { should be_able_to(:update, participant_group) }
      it { should be_able_to(:invite, participant_group) }

      context "group registration" do
        it { should be_able_to(:create, participant_group.group_registrations.new) }

        let(:group_registration) { FactoryGirl.create(:group_registration, participant_group: participant_group)}

        it { should_not be_able_to(:accept, group_registration) }
        it { should_not be_able_to(:reject, group_registration) }

        it { should be_able_to(:read, group_registration) }
        it { should be_able_to(:withdraw, group_registration) }

      end

    end
    context "when member" do
      before { participant_group.addParticipantGroupMember(member) }
      subject(:ability) { Ability.new(member) }
      it { should be_able_to(:show, participant_group) }

      context "registration" do
        let(:group_registration) { FactoryGirl.create(:group_registration, participant_group: participant_group)}
        it { should_not be_able_to(:accept, group_registration) }
        it { should_not be_able_to(:reject, group_registration) }

        it { should be_able_to(:read, group_registration) }
        it { should_not be_able_to(:withdraw, group_registration) }
      end
    end
  end

  describe "group registrations" do

    let(:manager) { FactoryGirl.create(:user) }
    let(:participant_group) { FactoryGirl.create(:participant_group)}


    context "when manager" do
      before { participant_group.addManager(manager) }
      let(:group_registration) { FactoryGirl.create(:group_registration, withdrawn: true, participant_group: participant_group)}

      subject(:ability) { Ability.new(manager) }

      it { should_not be_able_to(:withdraw, group_registration) }
    end
  end

  describe "users" do

    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    let(:administrator) { FactoryGirl.create(:user, initial_role: "administrator") }

    context "when another user" do
      subject(:ability) { Ability.new(other_user) }

      it { should be_able_to(:read, user) }
      it { should_not be_able_to(:update, user) }
      it { should_not be_able_to(:destroy, user) }
    end

    context "when user itself" do
      subject(:ability) { Ability.new(user) }

      it { should be_able_to(:read, user) }
      it { should be_able_to(:read_full_profile, user) }
      it { should be_able_to(:update, user) }
      it { should be_able_to(:destroy, user) }
    end

    context "when administrator" do

      subject(:ability) { Ability.new(administrator) }

      it { should be_able_to(:read, User) }
      it { should be_able_to(:read_full_profile, User) }
      it { should be_able_to(:update, User) }
      it { should be_able_to(:destroy, User) }
    end

    context "when going to the same conference" do
      subject(:ability) { Ability.new(user) }
      let(:familiar_user) {FactoryGirl.create(:user)}
      let(:conference) {FactoryGirl.create(:conference)}
      before { conference.addParticipant(user)}
      before { conference.addParticipant(familiar_user)}

      before { puts conference.participants.inspect}

      it { should be_able_to(:read_full_profile, familiar_user) }
      it { should be_able_to(:read, familiar_user) }
    end
  end

end
