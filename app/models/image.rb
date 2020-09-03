class Image < MediaItem
  translates :title

  serialize :thumbnail_sizes, Hash

  before_validation do
    self.photo_url = source_url
  end

  dragonfly_accessor :photo

  def thumb(size)
    if sizes = thumbnail_sizes[size]
      ret = OpenStruct.new(sizes)
      ret.url = Dragonfly.app.remote_url_for(ret.uid)
      ret
    else
      sizes = thumbnail_sizes[size] = compute_sizes(size)
      update_column(:thumbnail_sizes,thumbnail_sizes)
      OpenStruct.new(sizes)
    end
  rescue
    placeholder(size)    
  end

  private

  def compute_sizes(size)
    thumbnail = self.photo.thumb(size, format: :jpg).encode('jpg', '-quality 80')

    {
      :uid => thumbnail.store,
      :signature => thumbnail.signature,
      url: thumbnail.url,
      width: thumbnail.width,
      height: thumbnail.height
    }
  rescue Dragonfly::Job::Fetch::NotFound
    placeholder(size)
  end

  def placeholder(size)
    w, h = size.split('x')
    OpenStruct.new({
      url: "https://placehold.it/#{size}",
      width: w.to_i,
      height: h.to_i
    })
  end
end
