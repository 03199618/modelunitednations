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

    context "when manager" do
      before { conference.addManager(manager) }
      subject(:ability) { Ability.new(manager) }
      it { should be_able_to(:update, conference) }
    end
    context "when delegate" do
      before { conference.addDelegate(delegate) }
      subject(:ability) { Ability.new(delegate) }
      it { should be_able_to(:read, conference) }
    end
    context "not public" do
      let(:conference) { FactoryGirl.create(:conference, public: false)}

      context "when delegate" do
        before { conference.addDelegate(delegate) }
        subject(:ability) { Ability.new(delegate) }
        it { should be_able_to(:read, conference) }
      end

      context "when manager" do
        before { conference.addManager(manager) }
        subject(:ability) { Ability.new(manager) }
        it { should be_able_to(:read, conference) }
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

    describe
  end

end
