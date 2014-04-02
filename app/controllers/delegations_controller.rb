class DelegationsController < ApplicationController
  def show
    @delegation = Delegation.find(params[:id])
    authorize! :show, @delegation

    respond_to do |format|
      format.xml {render :xml => @delegation}
      format.json {render :json => @delegation}
      format.html { @delegation }
    end
  end

  def index
  end

  def new
    @delegation = Delegation.new
    authorize! :create, @delegation
  end

  def create
    @conference = Conference.find(params[:delegation][:conference_id])
    @delegation = @conference.delegations.new(params[:delegation].permit(:name))
    authorize! :create, @delegation

    if @delegation.save
      flash[:success] = t("general.conferenceCreated")
      respond_to do |format|
        format.xml {render :xml => @delegation}
        format.json {render :json => @delegation}
        format.html {redirect_to delegation_path(id: @delegation.id)}
      end
    else
      puts @delegation.errors.inspect
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
