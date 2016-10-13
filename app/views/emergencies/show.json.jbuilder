unless @emergency.nil?
  if @emergency.errors.present?
		json.message @emergency.errors
  else
	json.emergency(@emergency,:code,:fire_severity,:police_severity,:medical_severity)
	json.message(@emergency.message)
	json.emergency do |emergency|
		emergency.responders(@responders_name)
		emergency.full_response(@full_response_count)
	end
   end
end