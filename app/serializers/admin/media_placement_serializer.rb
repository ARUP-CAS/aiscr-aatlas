class Admin::MediaPlacementSerializer < ActiveModel::Serializer
  attributes :id, :position, :page, :title_en, :title_cs, :is_plan
  has_one :media_item, embed: :ids, embed_in_root: true, serializer: Admin::MediaItemSerializer

  def page
    if object.page
      type = object.page.class.to_s
      { id: object.page_id, type: type }
    end
  end


end
