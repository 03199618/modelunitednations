class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      gon.push({:intro => current_user.intro })
    end
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
