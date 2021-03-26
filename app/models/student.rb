class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :guardianships, dependent: :destroy

  validates :name, presence: true
end
