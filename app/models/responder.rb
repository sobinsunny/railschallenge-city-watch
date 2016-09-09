class Responder < ActiveRecord::Base 
	attr_reader :emergency_code
	before_save :default_values

	# Validation #
	
	validates :type,	presence: true
	validates :name,	presence: true,uniqueness: true
	validates :capacity,presence: true,inclusion: { in: 1..5,message: "is not included in the list"}
	 






private

def default_values
  	self.on_duty ||= false
  	true
end
  
  
end
