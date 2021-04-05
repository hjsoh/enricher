class CreateClassroomAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :classroom_announcements do |t|
      t.references :classroom, null: false, foreign_key: true
      t.references :announcement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
