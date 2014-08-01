class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.string :subject
      t.text :description
      t.integer :priority, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
