class Classroom < ApplicationRecord

  belongs_to :user


  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :tickets, dependent: :destroy
end
