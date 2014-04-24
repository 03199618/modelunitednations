# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    #index, show, new, create, edit, update, destroy
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user

    log_test "Checking abilites for user" if Rails.env.test?
    log_test user.inspect if Rails.env.test?

    if user.has_role? :administrator
      log_test "ADMINISTRATOR" if Rails.env.test?
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard

    elsif !user.id.nil? #logged in
      log_test "USER" if Rails.env.test?


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

      #Comittee

      can :create, Comittee do |comittee|
        comittee.conference.manager?(user)
      end

      can :read, Comittee do |comittee|
        comittee.conference.public? || comittee.conference.participant?(user)
      end

      can :update, Comittee do |comittee|
        comittee.conference.manager?(user)
      end

      can :destroy, Comittee do |comittee|
        comittee.conference.manager?(user)
      end

      #Comittee session

      can :create, ComitteeSession do |session|
        session.conference.manager?(user)
      end

      can :read, ComitteeSession do |session|
        false
      end

      can :update, ComitteeSession do |session|
        false
      end

      can :destroy, ComitteeSession do |session|
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

      can :create, GroupRegistration do
        true
      end

      can :read, GroupRegistration do |registration|
        registration.participant_group.member?(user) || registration.conference.manager?(user)
      end

      can [:reject, :accept], GroupRegistration do |registration|
        registration.conference.manager?(user)
      end

      can :withdraw, GroupRegistration do |registration|
        registration.participant_group.manager?(user) && !registration.withdrawn
      end

      #ParticipantGroup

      can :create, ParticipantGroup do
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

      can :destroy, ParticipantGroup do |group|
        group.manager?(user)
      end


    else #Guest
      can :index, Conference
      log_test "GUEST" if Rails.env.test?
      can :read, Conference do |conference|
        conference.public?
      end
    end

  end
end
