class Tag < ActsAsTaggableOn::Tag
  #FIXME: nepreklada
  translates :title

  scope :era, -> { where("era = ?", true) }

end
