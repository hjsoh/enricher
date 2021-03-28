class ChangeTicketStatusDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tickets, :is_private, from: true, to: false
  end
end
