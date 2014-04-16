class GroupRegistrationsController < ApplicationController
  def show
    @group_registration = GroupRegistration.find(params[:id])
    authorize! :show, @group_registration

    respond_to do |format|
      format.xml {render :xml => @group_registration}
      format.json {render :json => @group_registration}
      format.html { @group_registration }
    end
  end

  def index
  end

  def new
    @group_registration = GroupRegistration.new
    authorize! :create, @group_registration

    @participant_groups = current_user.participant_groups
    @conference = Conference.find(params[:conference_id])
  end

  def create
    @conference = Conference.find(params[:group_registration][:conference_id])
    @group_registration = @conference.group_registrations.new(params[:group_registration].permit(:participant_group_id, :conference_id))
    authorize! :create, @group_registration

    if @group_registration.save
      flash[:success] = t("general.group_registrationCreated")
      respond_to do |format|
        format.xml {render :xml => @group_registration}
        format.json {render :json => @group_registration}
        format.html {redirect_to group_registration_path(id: @group_registration.id)}
      end
    else
      @participant_groups = current_user.participant_groups
      @conference = Conference.find(params[:group_registration][:conference_id])
      render 'new'
    end
  end

  def edit
    @group_registration = GroupRegistration.find(params[:id])
    authorize! :update, @group_registration
  end

  def update
    @group_registration = GroupRegistration.find(params[:id])
    authorize! :update, @group_registration
  end

  def destroy
  end

  def withdraw
    @group_registration = GroupRegistration.find(params[:id])
    authorize! :withdraw, @group_registration

    @group_registration.withdraw

    if @group_registration.save
      flash[:success] = t("general.group_registrationSuccessfullyWithdrawn")
      respond_to do |format|
        format.xml {render :xml => @group_registration}
        format.json {render :json => @group_registration}
        format.html {redirect_to group_registration_path(id: @group_registration.id)}
      end
    else
      flash[:warning] = t("general.group_registrationUnsuccessfullyWithdrawn")
    end

  end

  def accept
    @group_registration = group_registration.find(params[:id])
    authorize! :withdraw, @group_registration

    @group_registration.accept

    if @group_registration.save
      flash[:success] = t("general.group_registrationSuccessfullyAccepted")
      respond_to do |format|
        format.xml {render :xml => @group_registration}
        format.json {render :json => @group_registration}
        format.html {redirect_to group_registration_path(id: @group_registration.id)}
      end
    else
      puts @group_registration.errors.inspect
      flash[:warning] = t("general.group_registrationUnsuccesfullyAccepted")
    end
  end


end