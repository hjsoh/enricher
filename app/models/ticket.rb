class Ticket < ApplicationRecord
  include PgSearch::Model
  #parent
  belongs_to :user

  #teacher
  belongs_to :classroom
  # delegate :user, :to => :classroom, :allow_nil => true

  #own your comments!
  has_many :comments, dependent: :destroy

  # def teacher
  #   User.find_by_id(id: self.teacher_id)
  # end

  # def parent
  #   User.find_by_id(id: self.parent_id)
  # end


  pg_search_scope :global_search,
    against: [ :question, :category_name ],
    associated_against: {
          user: [ :name ]
        },
    using: {
      tsearch: { prefix: true }
    }
end

