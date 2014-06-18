class Api::V1::ComitteesController < ApplicationController
  respond_to :json

  def index
    respond_with Committee.all
  end
end