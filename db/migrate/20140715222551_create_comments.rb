class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :ticket_id
      t.string :content

      t.timestamps
    end
  end
end
