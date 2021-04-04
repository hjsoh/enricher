class Announcement < ApplicationRecord
  has_many :classroom_announcements
  has_many :classrooms, through: :classroom_announcements, dependent: :destroy

  validates :title, presence: true
end
