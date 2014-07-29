class AddNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string, after: :ticket_id
  end
end
