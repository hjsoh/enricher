class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :email, :password, :password_confirmation

  has_many :tickets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :role, presence: true, inclusion: { in: ['teacher', 'parent'] }
  validates :name, presence: true

  # parent r/s
  has_many :guardianships
  has_many :students, through: :guardianships

  # teachers r/s
  has_many :classrooms

  def students_in_classrooms
    self.classrooms.students
  end
end
