class CreateLends < ActiveRecord::Migration[6.1]
  def change
    create_table :lends do |t|
      t.string :address
      t.integer :price
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
