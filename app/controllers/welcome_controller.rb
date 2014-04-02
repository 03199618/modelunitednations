class WelcomeController < ApplicationController
  def index
    @welcomecontroller = true
  end

  def theme
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
