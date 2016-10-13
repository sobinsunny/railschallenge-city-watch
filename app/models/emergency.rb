class Emergency < ActiveRecord::Base
  attr_reader :message

  has_many :responders, foreign_key: :emergency_code, primary_key: :code

  after_create :set_responders, on: :create

  validates :code, presence: true, uniqueness: true
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality:  { greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true,  numericality: { greater_than_or_equal_to: 0 }

  RESPONDER_TYPE = { medical_severity: 'Medical', fire_severity: 'Fire', police_severity: 'Police' }

  def self.available_responses
    [available_responders.count, total_emergency.count]
  end

  def set_responders # todo
    attributes.each do |column_name, value|
      unless   RESPONDER_TYPE[column_name.to_sym].nil?
        RESPONDER_TYPE[column_name.to_sym].constantize.assign_responders(code, value) if value.to_i > 0
      end
    end
  end

  def self.full_response
    3 / 5
  end

  private

  def self.available_responders
    Responder.available
  end

  def self.total_emergency
    all
  end
end
