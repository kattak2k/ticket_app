class ChangeStatusAndPriorityToInteger < ActiveRecord::Migration
  def change
    change_column :tickets, :status, :integer, default: 0
    change_column :tickets, :priority, :integer, default: 0
  end
end
