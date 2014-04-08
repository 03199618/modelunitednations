class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    authorize! :show, @event

    respond_to do |format|
      format.xml {render :xml => @event}
      format.json {render :json => @event}
      format.html { @event }
    end
  end

  def index
    redirect_to root_path
  end

  def new
    @event = Event.new
    authorize! :create, @event
  end

  def create
    @timetable = Timetable.find(params[:event][:timetable_id])
    @event = @timetable.events.new(params[:event].permit(:name, :starts_at, :ends_at, :description))
    authorize! :create, @event

    if @event.save
      flash[:success] = t("general.eventCreated")
      respond_to do |format|
        format.xml {render :xml => @event}
        format.json {render :json => @event}
        format.html {redirect_to conference_path(id: @timetable.conference.id)}
      end
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize! :update, @event
  end

  def update
    @event = Event.find(params[:id])
    authorize! :update, @event

    respond_to do |format|
      if @event.update(params[:event].permit(:position_paper))
        format.html { redirect_to(@event, :notice => t("event.succesfullyUpdated")) }
        format.json { @event }
      else
        format.html { render :action => "edit" }
        format.json { @event }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize! :destroy, @event

    @conference = @event.timetable.conference

    @event.destroy
    flash[:success] = t("event.sucessfullyDeleted")
    redirect_to @conference
  end

end
