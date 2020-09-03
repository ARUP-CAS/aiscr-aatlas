class CreateMediaPlacements < ActiveRecord::Migration
  def change
    create_table :media_placements do |t|
      t.string :title_cs
      t.string :title_en
      t.integer :position
      t.integer :place_id
      t.integer :media_item_id
      t.boolean :is_plan

      t.timestamps null: false
    end
  end
end
