require 'date'

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :office_hour

  validates :name, presence: true

  def parent
    self.user
  end

  def teacher
    self.office_hour.user
  end

  def start_time
    self.office_hour.start_time
  end

  def upcoming?
    self.office_hour.start_time > DateTime.now
  end
end
