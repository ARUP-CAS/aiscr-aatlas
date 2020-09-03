class Admin::PageSerializer < ActiveModel::Serializer
  attributes :id, :title_cs, :title_en, :subtitle_cs, :subtitle_en, :text_content_en, :text_content_cs,
     :map_text_content_en, :map_text_content_cs, :media_placements_count,
     :slug, :qr_id, :latitude, :longitude, :geo_coordinates, :address_cs, :address_en,
     :era_cs, :era_en

  has_many :tags, embed: :ids, embed_in_root: true, serializer: Admin::TagSerializer

  attributes :media_placement_ids, :media_item_ids
  has_many :media_placements, embed: :ids, embed_in_root: true, serializer: Admin::MediaPlacementSerializer
#

  def media_placements_count
    object.media_placements_count || 0
  end

end
