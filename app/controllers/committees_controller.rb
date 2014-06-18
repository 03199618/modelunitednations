class CommitteesController < ApplicationController
  def show
    @committee = Committee.find(params[:id])
    authorize! :show, @committee

    respond_to do |format|
      format.xml {render :xml => @committee}
      format.json {render :json => @committee}
      format.html { @committee }
    end
  end

  def index
  end

  def new
    @conference = Conference.find(params[:conference_id])
    @committee = @conference.committees.new
    authorize! :create, @committee
  end

  def create
    @conference = Conference.find(params[:committee][:conference_id])
    @committee = @conference.committees.new(params[:committee].permit(:name, :description, :topic))
    authorize! :create, @committee

    if @committee.save

      @committee.create_activity key: 'committee.committee_added', owner: @conference.participantForUser(current_user)
      flash[:success] = t("general.committeeCreated")
      respond_to do |format|
        format.xml {render :xml => @committee}
        format.json {render :json => @committee}
        format.html {redirect_to committee_path(id: @committee.id)}
      end
    else
      puts @committee.errors.inspect
      render 'new'
    end
  end

  def edit
    @committee = Committee.find(params[:id])
    authorize! :update, @committee
  end

  def update
    @committee = Committee.find(params[:id])
    authorize! :update, @committee

    respond_to do |format|
      if @committee.update(params[:committee].permit(:name, :description, :topic))
        format.html { redirect_to(@committee, :notice => t("committee.succesfullyUpdated")) }
        format.json { @committee }
      else
        format.html { render :action => "edit" }
        format.json { @committee }
      end
    end
  end

  def destroy
  end
end
