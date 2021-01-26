class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.datetime :date
      t.text :subject
      t.integer :hours_slept
      t.boolean :recurring
      t.integer :dream_id
    end
  end
end
