class RespondersController < ApplicationController
	def index
		@responders = Responder.all
	end

	def create
		build_responder
		status= 422
		if @responder.save
			status=201
		end
		render "show",:status=>status
	end


	def show
	end


	private

	def build_responder
		@responder ||= Responder.new(responder_params)
	end

	def responder_params
		params.require(:responder).permit(:name, :type, :capacity)	
	end


end
