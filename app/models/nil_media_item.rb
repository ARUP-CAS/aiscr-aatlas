require 'ostruct'

class NilMediaItem
  def thumb(w_x_h)
    w_x_h =~ /([0-9]+)x([0-9]+)?/
    OpenStruct.new(url: "http://placehold.it/#{w_x_h}?text=Thumbnail+missing",
                   height: $2,
                   width: $1)
  end
  
end
