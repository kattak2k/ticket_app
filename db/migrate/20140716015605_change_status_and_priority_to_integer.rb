class ChangeStatusAndPriorityToInteger < ActiveRecord::Migration
  def change
    change_column :tickets, :status, 'integer USING CAST(status AS integer)', default: 0
    change_column :tickets, :priority, 'integer USING CAST(priority AS integer)', default: 0
  end
end
