class CreateDreams < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.integer :hours_slept
      t.integer :person_id
    end
  end
end
