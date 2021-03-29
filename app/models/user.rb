class User < ApplicationRecord
  # Token
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # for the parent ticket
  has_many :tickets


  # for the teacher ticket
  has_many :classrooms
  has_many :tickets, :through => :classrooms

  # for the comments
  has_many :comments, :foreign_key => 'author_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: ['teacher', 'parent'] }
  validates :name, presence: true

  has_many :students, through: :guardianships
  has_many :classrooms
end
