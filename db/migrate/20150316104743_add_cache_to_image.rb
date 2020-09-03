class AddCacheToImage < ActiveRecord::Migration
  def change
    add_column :media_items, :thumbnail_sizes, :text, :default => {}.to_yaml
  end
end
