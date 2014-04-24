require 'spec_helper'

describe Conference do
  subject(:conference) {FactoryGirl.create(:conference)}
  describe "manager" do
    it "it should be able to add a manager" do
      conference = FactoryGirl.create(:conference)
      user = FactoryGirl.create(:user)

      conference.addManager(user)

      expect(conference.managers.pluck(:user_id)).to include(user.id)
    end

    it "it should return all managers" do
      conference = FactoryGirl.create(:conference)
      manager1 = FactoryGirl.create(:user)
      manager2 = FactoryGirl.create(:user)

      conference.addManager(manager1)
      conference.addManager(manager2)


      expect(conference.managers.pluck(:user_id)).to eq([manager1.id, manager2.id])
    end

    it "it should check a user for management" do
      conference = FactoryGirl.create(:conference)
      manager1 = FactoryGirl.create(:user)
      delegate = FactoryGirl.create(:user)

      conference.addManager(manager1)
      conference.addDelegate(delegate)

      expect(conference.manager?(manager1)).to be true
      expect(conference.manager?(delegate)).to be false
    end



  end

  describe "delegate" do
    it "it should be able to add a delegate" do
      conference = FactoryGirl.create(:conference)
      user = FactoryGirl.create(:user)

      conference.addDelegate(user)

      expect(conference.delegates.pluck(:user_id)).to include(user.id)
    end

    it "it should return all deleagtes" do
      conference = FactoryGirl.create(:conference)
      delegate1 = FactoryGirl.create(:user)
      delegate2 = FactoryGirl.create(:user)

      conference.addDelegate(delegate1)
      conference.addDelegate(delegate2)

      expect(conference.delegates.pluck(:user_id)).to eq([delegate1.id, delegate2.id])
    end

    it "it should check a user for being a delegate" do
      conference = FactoryGirl.create(:conference)
      delegate = FactoryGirl.create(:user)

      conference.addDelegate(delegate)

      expect(conference.delegate?(delegate)).to be true
    end


  end


  describe "name" do
    it "should require a name" do
      conference = FactoryGirl.build(:conference)
      conference.name = nil
      conference.should_not be_valid
    end

    it "should return its name on missing acronym" do
      conference = FactoryGirl.build(:conference)
      conference.acronym = nil
      conference.acronym.should eq conference.name
    end
  end

  describe "date" do
    it "should require a start date" do
      conference = FactoryGirl.build(:conference)
      conference.starts_at = nil
      conference.should_not be_valid
    end

    it "should require a start date" do
      conference = FactoryGirl.build(:conference)
      conference.ends_at = nil
      conference.should_not be_valid
    end
  end

  describe "size" do
    it "should have a size" do
      conference = FactoryGirl.build(:conference)
      conference.should respond_to :size
    end
  end

  describe "public" do
    it "should have be public" do
      conference = FactoryGirl.build(:conference)
      conference.public?.should eq true
    end

    it "should have be not public" do
      conference = FactoryGirl.build(:conference, public: false)
      conference.public?.should eq false
    end
  end

  describe "participant" do

    it "should check a user for participation" do
      conference = FactoryGirl.create(:conference)
      participant = FactoryGirl.create(:user)



      conference.addDelegate(participant)

      expect(conference.participant?(participant)).to be true
    end



  end

  describe "location" do
    it { should respond_to :latitude}
    it { should respond_to :longitude}

    it { should respond_to :street}
    it { should respond_to :city}
    it { should respond_to :zipcode}
    it { should respond_to :state}
    it { should respond_to :country}

    it { should respond_to :full_address}
    let(:full_address) {subject.street + ", " + subject.city + ", " +subject.zipcode + ", " +subject.state + ", " +subject.country}
    it { expect{ subject.full_address}.to eq full_address }


  end

  describe "registration" do

    it "should register a user" do
      conference = FactoryGirl.create(:conference)
      applicant = FactoryGirl.create(:user)



      conference.addRegistration(applicant)

      expect(conference.registrations.pluck(:user_id)).to eq([applicant.id])

    end

    it "should not register a user twice" do
      conference = FactoryGirl.create(:conference)
      applicant = FactoryGirl.create(:user)



      conference.addRegistration(applicant)

      expect(conference.addRegistration(applicant)).to be false

    end
  end
end
