class Announcement < ApplicationRecord
  has_many :classroom_announcements
  has_many :classrooms, through: :classroom_announcements, dependent: :destroy

  validates :title, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_contents,
    against: [ :title, :content ],
    using: {
      tsearch: { prefix:true }
    }
end
