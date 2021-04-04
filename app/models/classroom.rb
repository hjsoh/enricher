class Classroom < ApplicationRecord
  belongs_to :user

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :parents, through: :students
  has_many :tickets, dependent: :destroy
  has_many :messages
  has_many :classroom_announcements, dependent: :destroy
  has_many :announcements, through: :classroom_announcements
end
