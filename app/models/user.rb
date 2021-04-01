class User < ApplicationRecord
  # Token
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # for the parent ticket
  attr_accessor :email, :password, :password_confirmation
  has_many :tickets


  # for the teacher ticket
  has_many :classrooms
  has_many :tickets, :through => :classrooms

  # for the comments
  has_many :comments, :foreign_key => 'author_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable


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
