class RenamePlaceToPage < ActiveRecord::Migration
  def change
    rename_column :media_placements, :place_id, :page_id
  end
end
