class RegistrationsController < ApplicationController
  def show
    @registration = Registration.find(params[:id])
    authorize! :show, @registration

    respond_to do |format|
      format.xml {render :xml => @registration}
      format.json {render :json => @registration}
      format.html { @registration }
    end
  end

  def index
  end

  def new
    @registration = Registration.new
    authorize! :create, @registration
    @participant_groups = current_user.participant_groups
    @conference = Conference.find(params[:conference_id])
  end

  def create
    @conference = Conference.find(params[:registration][:conference_id])
    @registration = @conference.registrations.new(params[:registration].permit(:participant_group_id, :conference_id))
    authorize! :create, @registration

    if @registration.save
      flash[:success] = t("general.registrationCreated")
      respond_to do |format|
        format.xml {render :xml => @registration}
        format.json {render :json => @registration}
        format.html {redirect_to registration_path(id: @registration.id)}
      end
    else
      @participant_groups = current_user.participant_groups
      @conference = Conference.find(params[:registration][:conference_id])
      render 'new'
    end
  end

  def edit
    @registration = Registration.find(params[:id])
    authorize! :update, @registration
  end

  def update
    @registration = Registration.find(params[:id])
    authorize! :update, @registration
  end

  def destroy
  end

  def withdraw
    @registration = Registration.find(params[:id])
    authorize! :withdraw, @registration

    @registration.withdraw

    if @registration.save
      flash[:success] = t("general.registrationSuccessfullyWithdrawn")
      respond_to do |format|
        format.xml {render :xml => @registration}
        format.json {render :json => @registration}
        format.html {redirect_to registration_path(id: @registration.id)}
      end
    else
      flash[:warning] = t("general.registrationUnsuccessfullyWithdrawn")
    end

  end

  def accept
    @registration = Registration.find(params[:id])
    authorize! :withdraw, @registration

    @registration.accept

    if @registration.save
      flash[:success] = t("general.registrationSuccessfullyAccepted")
      respond_to do |format|
        format.xml {render :xml => @registration}
        format.json {render :json => @registration}
        format.html {redirect_to registration_path(id: @registration.id)}
      end
    else
      puts @registration.errors.inspect
      flash[:warning] = t("general.registrationUnsuccesfullyAccepted")
    end
  end


end
