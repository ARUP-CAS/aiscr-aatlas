class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :title_cs
      t.string :title_en
      t.string :subtitle_cs
      t.string :subtitle_en
      t.text :text_content_en
      t.text :text_content_cs

      t.text :map_text_content_en
      t.text :map_text_content_cs

      t.integer :media_placements_count
      t.string :slug
      t.string :qr_id, null: false

      t.decimal :latitude, precision: 11, scale: 7
      t.decimal :longitude, precision: 11, scale: 7
      t.string :geo_coordinates

      t.string :address_cs, :string, limit: 1024
      t.string :address_en, :string, limit: 1024
      t.string :era_cs
      t.string :era_en

      t.timestamps null: false
    end
  end
end
