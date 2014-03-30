# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    #index, show, new, create, edit, update, destroy
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new # guest user

    if user.has_role? :administrator
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard

      elsif user.has_role? :manager
      can :manage, Conference do |conference|
        conference.managers.user_id == user.id
      end

    elsif user.has_role? :delegate

    elsif user.has_role? :director

    else

      can :manage, :all
      can :read, Conference do |conference|
        conference.public?
      end
    end

  end
end
