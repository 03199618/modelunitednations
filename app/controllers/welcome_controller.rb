class WelcomeController < ApplicationController
  def index
    authorize! :read, Conference
  end

  def theme
  end
end
