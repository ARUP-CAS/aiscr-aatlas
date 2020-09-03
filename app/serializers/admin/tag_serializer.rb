class Admin::TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :era, :taggings_count, :title_cs, :title_en
end
