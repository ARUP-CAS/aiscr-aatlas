# -*- coding: utf-8 -*-
class Place < Page
  include PgSearch

  translates :title, :subtitle, :address, :era, :map_text_content, :text_content, :meta_title, :meta_description, :url

  validates :title_cs, presence: true
  validates :qr_id, format: { with: /[a-z0-9]{5}/, allow_blank: true }
  # validates :address_en, presence: true
  # validates :address_cs, presence: true
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true

  before_validation :compute_coordinates
  before_save :generate_slug

  # Scopes
  scope :ordered, -> { order("title_cs") }
  scope :with_coordinates, -> {
    where('latitude is not NULL and longitude is not NULL')
  }

  pg_search_scope :search, ignoring: :accents, against: %i[
    title_cs title_en
    subtitle_cs subtitle_en
    text_content_cs text_content_en
    map_text_content_cs map_text_content_en
    address_cs address_en
    era_cs era_en
  ]


  def to_param  # overridden
    self.slug.presence || self.id
  end

  def compute_coordinates
    return unless self.geo_coordinates

    lat, lng = geo_coordinates.scan(/(\d+)°\s*(\d+)['‘]\s*(\d+\.?\d*)["“]/).map do |d,m,s|
      d.to_f + m.to_f/60 + s.to_f/3600
    end

    self.latitude = lat
    self.longitude = lng
  end


  def cover_image
    if placement = media_placements_images.order("position").includes(:media_item).first
      placement.media_item
    else
      NilMediaItem.new
    end
  end

  def media_placements_images
    media_placements.joins(:media_item).where("media_items.type = 'Image'").order("position")
  end

  def media_placements_documents
    media_placements.joins(:media_item).where("media_items.type = 'Document'").order("position")
  end

  def self.last_update
    Place.order(updated_at: :desc).select(:updated_at).first.try(:updated_at) || 1.day.ago
  end

  private

    def generate_slug
      return if self.slug.present?
      slug = title_cs.parameterize
      sane = 0

      while Place.where(slug: slug).exists? && sane < 5
        slug = "#{slug}-"
        sane += 1
      end

      self.slug = slug
    end
end
