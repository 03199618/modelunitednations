class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    authorize! :show, @topic

    respond_to do |format|
      format.xml {render :xml => @topic}
      format.json {render :json => @topic}
      format.html { @topic }
    end
  end

  def index
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic
  end

  def create
    @comittee = Comittee.find(params[:topic][:comittee_id])
    @topic = @comittee.topics.new(params[:topic].permit(:name, :content))
    authorize! :create, @topic



    if @topic.save
      @comittee.addTopic(@topic)
      flash[:success] = t("general.topicCreated")
      respond_to do |format|
        format.xml {render :xml => @topic}
        format.json {render :json => @topic}
        format.html {redirect_to topic_path(id: @topic.id)}
      end
    else
      puts @topic.errors.inspect
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic

    respond_to do |format|
      if @topic.update(params[:topic].permit(:name, :content))
        format.html { redirect_to(@topic, :notice => t("topic.succesfullyUpdated")) }
        format.json { @topic }
      else
        format.html { render :action => "edit" }
        format.json { @topic }
      end
    end
  end

  def destroy
  end

end
