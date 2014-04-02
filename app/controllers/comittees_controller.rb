class ComitteesController < ApplicationController
  def show
    @comittee = Comittee.find(params[:id])
    authorize! :show, @comittee

    respond_to do |format|
      format.xml {render :xml => @comittee}
      format.json {render :json => @comittee}
      format.html { @comittee }
    end
  end

  def index
  end

  def new
    @comittee = Comittee.new
    authorize! :create, @comittee
  end

  def create
    @conference = Conference.find(params[:comittee][:conference_id])
    @comittee = @conference.comittees.new(params[:comittee].permit(:name, :description, :topic))
    authorize! :create, @comittee

    if @comittee.save

      @comittee.create_activity key: 'comittee.comittee_added', owner: @conference.participantForUser(current_user)
      flash[:success] = t("general.comitteeCreated")
      respond_to do |format|
        format.xml {render :xml => @comittee}
        format.json {render :json => @comittee}
        format.html {redirect_to comittee_path(id: @comittee.id)}
      end
    else
      puts @comittee.errors.inspect
      render 'new'
    end
  end

  def edit
    @comittee = Comittee.find(params[:id])
    authorize! :update, @comittee
  end

  def update
    @comittee = Comittee.find(params[:id])
    authorize! :update, @comittee

    respond_to do |format|
      if @comittee.update(params[:comittee].permit(:name, :description, :topic))
        format.html { redirect_to(@comittee, :notice => t("comittee.succesfullyUpdated")) }
        format.json { @comittee }
      else
        format.html { render :action => "edit" }
        format.json { @comittee }
      end
    end
  end

  def destroy
  end
end
