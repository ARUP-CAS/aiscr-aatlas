module ImageHelper
  def img_tag_retina(normal, retina, html_options = {})
    escaped_normal = URI.encode(normal)
    escaped_retina = URI.encode(retina)
    html_options[:srcset] = "#{escaped_normal} 1x, #{escaped_retina} 2x"
    image_tag escaped_normal, html_options
  end

  def img_tag_retina_static(path, html_options = {})
    split_path = path.split('.')
    retina_path = split_path.first(split_path.size - 1).join('.') + '@2x.' + split_path.last

    normal = image_path(path)
    retina = image_path(retina_path)

    img_tag_retina normal, retina, html_options
  end
end
