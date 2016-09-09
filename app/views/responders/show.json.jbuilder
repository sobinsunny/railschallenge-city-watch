if @responder.errors.present?
	json.message @responder.errors
else
	json.responder(@responder,:name,:emergency_code,:on_duty,:capacity,:type)
end