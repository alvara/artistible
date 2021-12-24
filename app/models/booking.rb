class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_one :review, dependent: :destroy


  enum status: { pending: 0, accepted: 1, declined: 2, archived: 3 }
  validates :start_time, :end_time, presence: true
  validate :valid_start_time?
  validate :valid_date_range?

  private

  def valid_start_time?
    if self.start_time < Date.today
      errors[:start_time] << "cannot precede current date"
    end
  end

  def valid_date_range?
    if self.end_time < self.start_time
      errors[:end_time] << "cannot precede start time"
    end
  end
end
