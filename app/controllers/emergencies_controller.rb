class EmergenciesController < ApplicationController
  def index
    @emergencies = Emergency.all
    @full_responses = Emergency.available_responses
  end

  def show
    find_emergency
    render status: 404  if @emergency.nil?
  end

  def create
    build_emergency
    status = 422
    status = 201 if @emergency.save
    @responders_name = @emergency.responders.collect(&:name)
    @full_response_count =  Emergency.full_response
    render 'show', status: status
  end

  def update
    find_emergency
    @emergency.update_attributes(update_params)
    render 'show', status: 201
  end

  private

  def find_emergency
    @emergency = Emergency.find_by_code(params[:code])
  end

  def build_emergency
    @emergency = Emergency.new(emeregency_params)
  end

  def update_params
    params[:emergency].permit(:resolved_at, :fire_severity, :police_severity, :medical_severity)
  end

  def emeregency_params
    params[:emergency].permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
