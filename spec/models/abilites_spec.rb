require 'spec_helper'
require "cancan/matchers"

describe User, "abilities" do
  subject(:ability) { Ability.new(user) }


  describe "conferences" do
    let(:guest) { FactoryGirl.build(:user) }
    let(:user) { FactoryGirl.build(:user) }
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

      context "group registration" do
        let(:group_registration) { FactoryGirl.create(:group_registration, conference: conference)}
        it { should be_able_to(:reject, group_registration) }
        it { should be_able_to(:read, group_registration) }
        it { should be_able_to(:accept, group_registration) }
      end
      context "events" do

        it { should be_able_to(:create, conference.timetable.events.new) }

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

    end

    describe "index" do
      subject(:ability) { Ability.new(nil) }
      it { should be_able_to(:index, conference) }
    end
  end

  describe "participant group" do
    let(:guest) { FactoryGirl.build(:user) }
    let(:user) { FactoryGirl.build(:user) }
    let(:manager) { FactoryGirl.create(:user) }
    let(:member) { FactoryGirl.create(:user) }
    let(:participant_group) { FactoryGirl.create(:participant_group)}

    context "when manager" do
      before { participant_group.addManager(manager) }

      subject(:ability) { Ability.new(manager) }

      it { should be_able_to(:update, participant_group) }

      context "group registration" do
        it { should be_able_to(:create, GroupRegistration) }

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

end
