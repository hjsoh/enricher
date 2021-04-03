class OfficeHour < ApplicationRecord
  belongs_to :user
  has_one :appointment
end
