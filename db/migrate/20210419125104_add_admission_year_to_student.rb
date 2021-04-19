class AddAdmissionYearToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :admission_year, :integer
  end
end
