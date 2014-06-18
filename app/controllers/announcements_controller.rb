class AnnouncementsController < ApplicationController
  before_filter :find_announced_at

  def new
    if !params[:comittee_id].nil?
      @announced_at = Committee.find(params[:comittee_id])
    elsif !params[:conference_id].nil?
      @announced_at = Conference.find(params[:conference_id])
    elsif !params[:participant_group_id].nil?
      @announced_at = ParticipantGroup.find(params[:participant_group_id])
    end
    @announcement = @announced_at.announcements.new
  end

  def create
    @announcement = @announced_at.announcements.create(params[:announcement].permit(:title, :content))
    respond_to do |format|
      format.html {redirect_to :controller => @announced_at.class.to_s.pluralize.downcase, :action => :show, :id => @announced_at.id}
    end
  end

  private

  def find_announced_at
    if !params[:announcement].nil? && !params[:announcement][:announced_at_type].nil?
      @klass = params[:announcement][:announced_at_type].capitalize.constantize
      @announced_at = @klass.find(params[:announcement][:announced_at_id])
    end
  end
end
