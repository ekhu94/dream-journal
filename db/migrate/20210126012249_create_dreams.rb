class CreateDreams < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.string :category
      t.integer :remembrance
      t.boolean :recurring
      t.integer :person_id
    end
  end
end
