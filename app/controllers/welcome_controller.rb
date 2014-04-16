class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      gon.push({:intro => current_user.settings(:intro) })
    end
  end

  def theme
  end
end
