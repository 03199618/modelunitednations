class ResolutionsController < ApplicationController
  def show
    @resolution = Resolution.find(params[:id])
    authorize! :show, @resolution
  end

  def index
    @resolutions = current_user.resolutions.order('updated_at DESC')
    authorize! :show, @resolutions
  end

  def new
    @resolution = Resolution.new
    authorize! :create, @resolution

    @topic = Topic.find(params[:topic_id])
  end

  def create
    @topic = Topic.find(params[:resolution][:topic_id])
    @resolution = Resolution.new(params[:resolution].permit(:content))
    authorize! :create, @resolution

    @topic.addResolution(@resolution)

    if @resolution.save
      @resolution.addResolutionSubmitter(@topic.conference.participantForUser(current_user).delegate, "mainsubmitter")
      if @resolution.save
        flash[:success] = t("general.resolutionCreated")
        respond_to do |format|
          format.xml {render :xml => @resolution}
          format.json {render :json => @resolution}
          format.html {redirect_to resolution_path(id: @resolution.id)}
        end
      end
    else
      render 'new'
    end
  end
end
