class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :office_hour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
