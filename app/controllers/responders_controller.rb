class RespondersController < ApplicationController
  def index
    if params[:show] == 'capacity'
      @responders_capacity = Responder.total_capacity
    else
      @responders = Responder.all
    end
  end

  def create
    build_responder
    status = @responder.save ? 201 : 422
    render 'show', status: status
  end

  def update
    find_responder
    @responder.update_attributes(update_params)
    render 'show', status: 201
  end

  def show
    find_responder
    render status: 404  if @responder.nil?
  end

  private

  def update_params
    params.require(:responder).permit(:on_duty)
  end

  def find_responder
    @responder = Responder.find_by_name(params[:id])
  end

  def build_responder
    @responder ||= Responder.new(responder_params)
  end

  def responder_params
    params.require(:responder).permit(:name, :type, :capacity).permitted?
  end
end
