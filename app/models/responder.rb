class Responder < ActiveRecord::Base
  belongs_to :emergency, foreign_key: :emergency_code, primary_key: :code

  # call backs #
  before_save :default_values

  # Validation #

  validates :type,	presence: true
  validates :name,	presence: true, uniqueness: true
  validates :capacity, presence: true, inclusion: { in: 1..5, message: 'is not included in the list' }

  # scopes
  scope :order_in_capacity, -> { order('capacity DESC') }
  scope :available, -> { where(on_duty: true) }
  scope :unassigned_resoponders, -> { where(emergency_code: nil) }
  scope :available_with_emergency, -> { where("emergency_code IS NOT NULL OR on_duty=1")}
  scope :assignd_responders, -> { where.not(emergency_code: nil) }

  TYPES = %w(Fire Police Medical)

  def self.total_capacity
    capacity_hash = {}
    TYPES.each do |type|
      capacity_hash[type] = [
        type.constantize.sum(:capacity),
        type.constantize.unassigned_resoponders.sum(:capacity),
        type.constantize.available_with_emergency.sum(:capacity),
        type.constantize.available.assignd_responders.sum(:capacity)
      ]
    end
    capacity_hash
    end

  private

  def default_values
    self.on_duty ||= false
    true
  end
end
