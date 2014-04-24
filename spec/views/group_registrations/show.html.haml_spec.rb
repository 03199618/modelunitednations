require 'spec_helper'

describe "group_registrations/show.html.haml" do

  before :each do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
    @ability.can :manage, :all

    @participant_group = FactoryGirl.create(:participant_group)

    3.times do
      @participant_group.addParticipantGroupMember(FactoryGirl.create(:user))
    end
    @group_registration = FactoryGirl.create(:group_registration, participant_group: @participant_group)

    assign(:group_registration, @group_registration)
  end
  it "displays the group members" do

    render

    @participant_group.participant_group_members.each do |member|
      rendered.should have_content(member.name)
    end
  end

  it "displays the conference name" do

    render
    rendered.should have_content(@group_registration.conference.acronym)

  end

  context "status" do
     it "should be withdrawn" do
       @group_registration.withdraw
       @group_registration.save
       render
       rendered.should have_content "withdrawn"
     end

     it "should be rejected" do
       @group_registration.reject
       @group_registration.save
       render
       rendered.should have_content "rejected"
     end

     it "should be rejected" do
       @group_registration.accept
       @group_registration.save
       render
       rendered.should have_content "accepted"
     end



  end
end
