class CreateMediaItems < ActiveRecord::Migration
  def change
    create_table :media_items do |t|
      t.string   :copyright_en
      t.string   :copyright_cs
      t.string   :source_url, limit: 2048
      t.string   :photo_uid
      t.string   :photo_name
      t.string   :thumbnail_uid
      t.string   :thumbnail_name
      t.string   :type, default: 'Image', null: false

      t.timestamps null: false
    end
  end
end
