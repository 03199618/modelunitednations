class ParticipantsController < ApplicationController
  def show
    @participant = Participant.find(params[:id])
    authorize! :show, @participant

    respond_to do |format|
      format.xml {render :xml => @participant}
      format.json {render :json => @participant}
      format.html { @participant }
    end
  end

  def index
    @conference = Conference.find(params[:conference_id])

    authorize! :index_participants, @conference

    @participants = @conference.participants
  end

  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end

  def edit
    redirect_to root_path
  end

  def update
    redirect_to root_path
  end

  def destroy
    @participant = Participant.find(params[:id])
    authorize! :destroy, @participant

    @conference = @participant.conference

    @participant.destroy
    flash[:success] = t("participant.sucessfullyDeleted")
    redirect_to @conference
  end
end
