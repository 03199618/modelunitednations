class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize! :show, @user

    respond_to do |format|
      format.xml {render :xml => @user}
      format.json {render :json => @user}
      format.html { @user }
    end
  end
end
