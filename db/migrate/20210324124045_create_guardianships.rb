class CreateGuardianships < ActiveRecord::Migration[6.0]
  def change
    create_table :guardianships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
