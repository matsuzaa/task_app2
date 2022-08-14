class AddNameToBorrows < ActiveRecord::Migration[6.1]
  def change
    add_column :borrows, :name, :string
  end
end
