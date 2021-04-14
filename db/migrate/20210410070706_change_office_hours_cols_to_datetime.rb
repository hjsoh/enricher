class ChangeOfficeHoursColsToDatetime < ActiveRecord::Migration[6.0]
  def change
    remove_column :office_hours, :start_time
    remove_column :office_hours, :end_time
    remove_column :office_hours, :date, :date

    add_column :office_hours, :start_time, :datetime
    add_column :office_hours, :end_time, :datetime
  end
end
