class Comment < ApplicationRecord
  belongs_to :ticket
 # belongs_to :author, class_name: 'User', foreign_key: 'author_id', validate: true

end
