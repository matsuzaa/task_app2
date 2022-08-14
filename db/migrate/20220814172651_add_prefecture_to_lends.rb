class AddPrefectureToLends < ActiveRecord::Migration[6.1]
  def change
    add_column :lends, :Prefecture, :string
  end
end
