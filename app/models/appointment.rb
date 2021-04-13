class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :office_hour

  validates :name, presence: true
end
