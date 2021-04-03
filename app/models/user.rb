class User < ApplicationRecord
  # Token
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # for the parent ticket
  # attr_accessor :email, :password, :password_confirmation
  has_many :tickets
  has_many :appointments
  has_many :office_hours
  has_many :teacher_appointments, through: :office_hours, source: :appointment

  # for the teacher ticket
  has_many :classrooms
  has_many :tickets, :through => :classrooms

  # for the comments
  has_many :comments, :foreign_key => 'author_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]


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

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
            name: data["name"],
            email: data["email"],
            encrypted_password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
