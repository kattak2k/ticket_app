class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.string :subject
      t.text :description
      t.integer :priority, limit: 2, null: false, default: 0
      t.integer :status, limit: 2, null: false, default: 0

      t.timestamps
    end
  end
end
