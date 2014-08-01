class ChangeStatusAndPriorityToInteger < ActiveRecord::Migration
  def change
    change_column_default :tickets, :status, "0"
    change_column_default :tickets, :priority, "0"
    change_column :tickets, :status, 'integer USING (trim(status)::integer)', default: 0
    change_column :tickets, :priority, 'integer USING (trim(priority)::integer)', default: 0
  end
end
