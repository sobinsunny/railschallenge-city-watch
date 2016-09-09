class Emergency < ActiveRecord::Base
 has_many :responders
 validates :code, uniqueness: true

 validates :code, presence: true
 validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
 validates :fire_severity, presence: true,numericality:  { greater_than_or_equal_to: 0 }
 validates :police_severity, presence: true,  numericality: { greater_than_or_equal_to: 0 }

end
