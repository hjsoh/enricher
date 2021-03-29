class User < ApplicationRecord
  # Token
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tickets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: ['teacher', 'parent'] }
  validates :name, presence: true

  has_many :students, through: :guardianships
  has_many :classrooms
end
