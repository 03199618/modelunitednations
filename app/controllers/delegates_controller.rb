class DelegatesController < ApplicationController
  def show
    @delegate = Delegate.find(params[:id])
    authorize! :show, @delegate

    respond_to do |format|
      format.xml {render :xml => @delegate}
      format.json {render :json => @delegate}
      format.html { @delegate }
    end
  end

  def index
  end

  def new
    puts "what"
    @delegate = Delegate.new
    authorize! :create, @delegate

    @conference = conference_resource.conference
    puts @conference.inspect
    puts "what"

  end

  def create
    @delegation = Delegation.find(params[:delegate][:delegation_id])
    @delegate = @delegation.delegates.new(params[:delegate].permit(:name, :delegation_id, :comittee_id, :participant_id))
    authorize! :create, @delegate

    if params[:delegate][:comittee_id]
      @delegate.comittee = Committee.find(params[:delegate][:comittee_id])
    end
    if params[:delegate][:participant_id]
      @delegate.participant = Participant.find(params[:delegate][:participant_id])
    end

    if @delegate.save
      flash[:success] = t("general.delegateCreated")
      respond_to do |format|
        format.xml {render :xml => @delegate}
        format.json {render :json => @delegate}
        format.html {redirect_to delegate_path(id: @delegate.id)}
      end
    else
      puts @delegate.errors.inspect
      render 'new'
    end
  end

  def edit
    @delegate = Delegate.find(params[:id])
    authorize! :update, @delegate
    @conference = @delegate.conference
  end

  def update
    @delegate = Delegate.find(params[:id])
    authorize! :update, @delegate

    respond_to do |format|
      if @delegate.update(params[:delegate].permit(:position_paper))
        format.html { redirect_to(@delegate, :notice => t("delegate.succesfullyUpdated")) }
        format.json { @delegate }
      else
        format.html { render :action => "edit" }
        format.json { @delegate }
      end
    end
  end

  def destroy
    @delegate = Delegate.find(params[:id])
    authorize! :destroy, @delegate

    @delegation = @delegate.delegation

    @delegate.destroy
    flash[:success] = t("delegate.sucessfullyDeleted")
    redirect_to @delegation
  end

  private

  def conference_resource
    if params[:delegation_id]
      @conference_resource = Delegation.find(params[:delegation_id])
    elsif params[:comittee_id]
      Committee.find(params[:comittee_id])
    else
      nil
    end
  end
end
