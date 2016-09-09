class EmergenciesController < ApplicationController
  def index
  end

  def show
  end

  def create
    emergency = Emergency.create(params[:emergency])
    respond_with emergency
  end

  def update
  end
end
