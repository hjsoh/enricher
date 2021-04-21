class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :classrooms, through: :enrollments, dependent: :destroy
  has_many :guardianships, dependent: :destroy
  has_many :parents, through: :guardianships, source: :user

  validates :name, presence: true
  validates :admission_year, presence: true

  def teachers
    self.guardianships
  end
end
