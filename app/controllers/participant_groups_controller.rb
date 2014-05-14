class ParticipantGroupsController < ApplicationController

  def show
    @participant_group = ParticipantGroup.find(params[:id])
    authorize! :show, @participant_group

    respond_to do |format|
      format.xml {render :xml => @participant_group}
      format.json {render :json => @participant_group}
      format.html { @participant_group }
    end
  end

  def index
  end

  def new
    @participant_group = ParticipantGroup.new
    authorize! :create, @participant_group
  end

  def create
    @participant_group = ParticipantGroup.new(params[:participant_group].permit(:name))
    authorize! :create, @participant_group



    if @participant_group.save
      @participant_group.addManager(current_user)
      if @participant_group.save
        flash[:success] = t("general.participant_groupCreated")
        respond_to do |format|
          format.xml {render :xml => @participant_group}
          format.json {render :json => @participant_group}
          format.html {redirect_to participant_group_path(id: @participant_group.id)}
        end
      end
    else
      puts @participant_group.errors.inspect
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def invite
    @participant_group = ParticipantGroup.find(params[:id])
    authorize! :invite, @participant_group

    if !params[:email].nil?
      @key = @participant_group.key(params[:email])
    end

    @participant_group = ParticipantGroup.find(params[:id])
  end


  def join
    @participant_group = ParticipantGroup.find(params[:id])
    authorize! :join, @participant_group

    if @participant_group.join(current_user, params[:key])
      redirect_to participant_group_path(id:@participant_group.id), notice: "You have joined the group."
    else
      redirect_to participant_group_path(id:@participant_group.id), notice: "The key seems to be wrong."
    end
  end

end
