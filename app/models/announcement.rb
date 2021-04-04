class Announcement < ApplicationRecord
  has_one :classroom_announcement, dependent: :destroy

  validates :title, presence: true
end
