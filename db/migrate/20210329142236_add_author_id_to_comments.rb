class AddAuthorIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :author_id, :integer
    add_foreign_key :comments, :users, column: :author_id
  end
end
