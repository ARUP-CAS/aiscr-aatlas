class Admin::MediaItemSerializer < ActiveModel::Serializer
  attributes :id, :copyright_en, :copyright_cs, :type, :page_ids, :source_url, :thumbnail_url

  def type
    object.type.underscore
  end

  def thumbnail_url
    object.thumb('400x400#').url if object.respond_to?(:photo) && !object.photo.nil?
  end

end
