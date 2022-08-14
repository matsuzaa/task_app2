class AddPrefectureIdToLends < ActiveRecord::Migration[6.1]
  def change
    add_column :lends, :prefecture_id, :integer
  end
end
