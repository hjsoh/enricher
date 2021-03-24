class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.boolean :is_private
      t.string :status
      t.string :question
      t.string :category_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
