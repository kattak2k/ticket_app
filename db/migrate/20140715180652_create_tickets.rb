class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.string :subject
      t.text :description
      t.string :priority, null: false, default: 'low'
      t.string :status, null: false, default: 'open'

      t.timestamps
    end
  end
end
