class CreateBorrows < ActiveRecord::Migration[6.1]
  def change
    create_table :borrows do |t|
      t.integer :user_id
      t.integer :lend_id
      t.date :start_day
      t.date :end_day
      t.integer :stay
      t.integer :peoples
      t.integer :total

      t.timestamps
    end
  end
end
