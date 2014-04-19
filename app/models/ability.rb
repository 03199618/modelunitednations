# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    #index, show, new, create, edit, update, destroy
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user

    log_test "Checking abilites for user"
    log_test user.inspect

    if user.has_role? :administrator
      log_test "ADMINISTRATOR"
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard

    elsif !user.id.nil? #logged in
      log_test "USER"

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


    else #Guest
      log_test "GUEST"
      can :read, Conference do |conference|
        conference.public?
      end
    end

  end
end
