class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.string :category
      t.integer :remembrance
      t.text :description
      t.boolean :recurring
      t.integer :dream_id
    end
  end
end
