class CommitteeSessionsController < ApplicationController
  def index
    @committeesessions= CommitteeSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @committeesessions}
    end
  end

  # GET /contacts/1.json
  def show
    @committeesession = CommitteeSession.find(params[:id])

    respond_to do |format|
      format.json { render json: @committeesession }
    end
  end

  # POST /contacts.json
  def create
    @committeesession = CommitteeSession.new(params[:committee_session])

    respond_to do |format|
      if @committeesession.save
        format.json { render json: @committeesession, status: :created, location: @committeesession }
      else
        format.json { render json: @committeesession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1.json
  def update
    @committeesession = CommitteeSession.find(params[:id])

    respond_to do |format|
      if @committeesession.update_attributes(params[:committee_session])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @committeesession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1.json
  def destroy
    @committeesession = CommitteeSession.find(params[:id])
    @committeesession.destroy

    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end
