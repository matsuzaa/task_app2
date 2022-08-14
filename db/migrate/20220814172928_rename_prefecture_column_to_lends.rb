class RenamePrefectureColumnToLends < ActiveRecord::Migration[6.1]
  def change
    rename_column :lends, :prefecture, :prefect
  end
end
