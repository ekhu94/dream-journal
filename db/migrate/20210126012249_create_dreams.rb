class CreateDreams < ActiveRecord::Migration[6.1]
  def change
    create_table :dreams do |t|
      t.datetime :date
      t.integer :hours_slept
      t.integer :user_id
    end
  end
end
