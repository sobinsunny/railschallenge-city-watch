class EmergenciesController < ApplicationController
  def index
  end

  def show
  end

  def create
    emergency = Emergency.create(emergency_params)
    respond_with emergency
  end

  def update
  end

protect

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
