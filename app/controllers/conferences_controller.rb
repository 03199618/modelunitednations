class ConferencesController < ApplicationController
  def show
    @conference = Conference.find(params[:id])
    authorize! :show, @conference

    respond_to do |format|
      format.xml {render :xml => @conference}
      format.json {render :json => @conference}
      format.html { @conference }

    end
  end

  def index
    @conferences = Conference.all
    authorize! :show, @conferences
  end

  def new
    @conference = Conference.new
    authorize! :create, @conference
  end

  def create
    @conference = Conference.new(params[:conference].permit(:name, :acronym, :description, :topic, :website_url, :public))

    authorize! :create, @conference

    @conference.addManager(current_user)

    if @conference.save
      flash[:success] = t("general.conferenceCreated")
      respond_to do |format|
        format.xml {render :xml => @conference}
        format.json {render :json => @conference}
        format.html {redirect_to conference_path(id: @conference.id)}
      end
    else
      render 'new'
    end
  end

  def edit
    @conference = Conference.find(params[:id])
    authorize! :update, @conference
  end

  def update
    @conference = Conference.find(params[:id])
    authorize! :update, @conference

    respond_to do |format|
      if @conference.update(params[:conference].permit(:id, :name, :acronym, :description, :topic, :website_url, :public))
        format.html { redirect_to(@conference, :notice => t("conference.succesfullyUpdated")) }
        format.json { @conference }
      else
        format.html { render :action => "edit" }
        format.json { @conference }
      end
    end
  end

  def destroy
    @conference = Conference.find(params[:id])
    authorize! :destroy, @conference

    @conference.destroy
    flash[:success] = t("conference.sucessfullyDeleted")
    redirect_to conferences_path
  end

  def placards
    @conference = Conference.find(params[:id])
    authorize! :show, @conference

    respond_to do |format|
      format.pdf { send_data @conference.placards.render, :filename => "x.pdf", :type => "application/pdf" }
    end
  end

  private

  def permitted_paramaters

  end

end
