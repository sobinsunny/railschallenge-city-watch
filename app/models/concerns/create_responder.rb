module CreateResponder
	extend ActiveSupport::Concern
	module ClassMethods
		def assign_responders(emergency_code,severity_count)
	    responder = self.unassigned_resoponders.find_by_capacity(severity_count) # move to concern
	    if responder.present?
	      responder.update_emergency_code(emergency_code)
	    else
	      lesser_capacity_responders = self.unassigned_resoponders.order_in_capacity.where('capacity < ?',severity_count) # name rechange=sev
	      remain_capacity = severity_count
	      if lesser_capacity_responders.present?
	        lesser_capacity_responders.each do |responder|
	          break  if remain_capacity <= 0
	          responder.update_emergency_code(emergency_code)
	          remain_capacity -= responder.capacity
	        end
	      end
	    end
		end
  end
	def update_emergency_code(code)
    update_attributes({emergency_code: code,on_duty: false})
  end
end