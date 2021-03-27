class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.boolean :is_private
      t.string :status
      t.string :question
      t.references :user, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.string :category_name

      t.timestamps
    end
  end
end
