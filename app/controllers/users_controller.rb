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

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_to do |format|
      if @user.update(params[:delegate].permit(:surname, :firstname))
        format.html { redirect_to(@user, :notice => t("user.succesfullyUpdated")) }
        format.json { @user }
      else
        format.html { render :action => "edit" }
        format.json { @user }
      end
    end
  end
end
