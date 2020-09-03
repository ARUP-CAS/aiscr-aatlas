class MediaItem < ActiveRecord::Base
  translates :copyright

  # Relations
  has_many :media_placements
  has_many :pages, through: :media_placements

  # Validations
  validates :source_url, presence: true

  def default_title
    File.basename(source_url).presence ||
      'New media item'
  end
end
