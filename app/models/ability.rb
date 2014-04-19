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

      can :create, Conference do |conference|
        true
      end

      can :read, Conference do |conference|
        conference.participant?(user) || conference.public?
      end

      can :update, Conference do |conference|
        conference.manager?(user)
      end

      can :destroy, Conference do |conference|
        conference.manager?(user)
      end

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

      can :read, GroupRegistration do |registration|
        registration.participant_group.member?(user) || registration.conference.manager?(user)
      end

      can [:reject, :accept], GroupRegistration do |registration|
        registration.conference.manager?(user)
      end

    else #Guest
      log_test "GUEST" if Rails.env.test?
      can :read, Conference do |conference|
        conference.public?
      end
    end

  end
end
