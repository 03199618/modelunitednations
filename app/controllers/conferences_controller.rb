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
    @conference = Conference.new(params[:conference].permit(:name, :description))
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
  end

  def update
  end

  def destroy
  end
end
