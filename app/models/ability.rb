# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    puts "ABILITY IS: "
    #index, show, new, create, edit, update, destroy
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user

    log_test "Checking abilites for user" if Rails.env.test?
    log_test user.inspect if Rails.env.test?

    if user.has_role? :administrator
      puts "ADMINISTRATOR"
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard

    elsif !user.id.nil? #logged in
      puts "USER"


      #User
      can :read, User

      can :read_full_profile, User do |u|
        u.id == user.id || user.common_conferences(u).any?
      end


      cannot :index, User

      can :update, User do |u|
        u.id == user.id
      end

      can :destroy, User do |u|
        u.id == user.id
      end

      #Conference
      can :create, Conference

      can :show, Conference do |conference|
        conference.participant?(user) || conference.public?
      end

      can :index, Conference

      can :index_participants, Conference do |conference|
        conference.manager?(user)
      end

      can :update, Conference do |conference|
        conference.manager?(user)
      end

      can :destroy, Conference do |conference|
        conference.manager?(user)
      end

      #committee

      can :create, Committee do |committee|
        committee.conference.manager?(user)
      end

      can :read, Committee do |committee|
        puts committee.conference.participants.inspect
        puts user.inspect
        committee.conference.public? || committee.conference.participant?(user)
      end

      can :update, Committee do |committee|
        committee.conference.manager?(user)
      end

      can :destroy, Committee do |committee|
        committee.conference.manager?(user)
      end

      #Delegation

      can :create, Delegation do |delegation|
        delegation.conference.manager?(user)
      end

      can :read, Delegation do |delegation|
        delegation.conference.public? || delegation.conference.participant?(user)
      end

      can :update, Delegation do |delegation|
        delegation.conference.manager?(user)
      end

      can :destroy, Delegation do |delegation|
        delegation.conference.manager?(user)
      end

      #committee session

      can :create, CommitteeSession do |session|
        session.conference.manager?(user)
      end

      can :read, CommitteeSession do |session|
        false
      end

      can :update, CommitteeSession do |session|
        false
      end

      can :destroy, CommitteeSession do |session|
        false
      end

      #Registration

      can :create, Registration do
        true
      end

      can :read, Registration do |registration|
        if registration.user_id == user.id || registration.conference.manager?(user)
          true
        elsif !registration.participant_group.nil? && registration.participant_group.manager?(user)
          true
        else
          false
        end
      end

      can [:reject, :accept], Registration do |registration|
        registration.conference.manager?(user)
      end

      can :create, Registration do
        true
      end

      #Event

      can :create, Event do |event|

        puts event.inspect
        event.timetable.conference.manager?(user)
      end

      #GroupRegistration

      can :create, GroupRegistration do |registration|
        true
      end

      can :read, GroupRegistration do |registration|
        registration.participant_group.member?(user) || registration.conference.manager?(user)
      end

      can [:reject, :accept], GroupRegistration do |registration|
        registration.conference.manager?(user) && !registration.withdrawn && !registration.accepted
      end

      can :withdraw, GroupRegistration do |registration|
        registration.participant_group.manager?(user) && !registration.withdrawn
      end

      #ParticipantGroup

      can :create, ParticipantGroup do |group|
        true
      end

      can :read, ParticipantGroup do |group|
        group.member?(user)
      end

      can :index, ParticipantGroup do |group|
        false
      end

      can :update, ParticipantGroup do |group|
        group.manager?(user)
      end

      can :invite, ParticipantGroup do |group|
        puts group.participant_group_members
        group.manager?(user)
      end

      can :join, ParticipantGroup do
        true
      end

      can :destroy, ParticipantGroup do |group|
        group.manager?(user)
      end


    else #Guest
      puts "GUEST"
      can :index, Conference

      can :read, Conference do |conference|
        conference.public?
      end
    end

  end
end
