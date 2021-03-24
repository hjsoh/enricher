class CreateOfficeHours < ActiveRecord::Migration[6.0]
  def change
    create_table :office_hours do |t|
      t.datetime :date
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
