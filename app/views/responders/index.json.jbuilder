if params[:show].present?
	json.capacity(@responders_capacity)
else
	json.responders @responders do |responder|
	  json.emergency_code responder.emergency_code
	  json.type responder.type
	  json.name responder.name
	end
end