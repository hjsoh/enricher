class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.boolean :is_active
      t.string :academic_year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
