class Ticket < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  belongs_to :classroom
  has_many :comments, dependent: :destroy

  validetes :classroom, presence: true

  pg_search_scope :global_search,
    against: [:question, :category_name],
    associated_against: {
      user: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }

  def parent
    self.user.name
  end

  def teacher
    self.classroom.user.name
  end

  def open?
    self.status != 'Completed'
  end
end
