class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.boolean :is_active
      t.string :name

      t.timestamps
    end
  end
end
