class AddNameToLends < ActiveRecord::Migration[6.1]
  def change
    add_column :lends, :name, :string
  end
end
