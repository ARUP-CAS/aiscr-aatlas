# -*- coding: utf-8 -*-
class PlacePrinter < ApplicationController
  attr_accessor :pdf_name, :place_url

  def initialize(place, place_url)
    @place = place
    @pdf_name = "#{place.title.parameterize}.pdf"
    @place_url = place_url
  end

  def print
    @pdf = Prawn::Document.new(top_margin: 60)

    font
    heading
    meta

    main_image

    text_content

    plans
    images

    page_headers_and_footers

    @pdf.render
  end

  private

    def print_name
      "#{@place.title.parameterize}.pdf"
    end

    def font
      @pdf.font_families.update('OpenSans' => {
        normal: Rails.root.join('data/fonts/OpenSans-Regular.ttf'),
        italic: Rails.root.join('data/fonts/OpenSans-Italic.ttf'),
        bold: Rails.root.join('data/fonts/OpenSans-SemiBold.ttf'),
        bold_italic: Rails.root.join('data/fonts/OpenSans-SemiBoldItalic.ttf')
      })
      @pdf.font 'OpenSans'
      @pdf.font_size 10
      @pdf.default_leading 4
    end

    def heading
      @pdf.text [@place.title, @place.address].compact.join(', '), size: 18,
                                                                   style: :bold
      @pdf.move_down 10
    end

    def meta
      @pdf.text @place.subtitle, style: :bold
      @pdf.move_down 7

      @pdf.text @place.era
      @pdf.move_down 20
    end

    def main_image
      image = @place.media_placements_images.not_plans.first

      if image.present?
        @pdf.image open(image.media_item.thumb('1200x').url),
                   fit: [bounds.width, bounds.height]
        @pdf.move_down 28
      end
    end

    def text_content
      regexp = /(\*{2}[^\*]*\*{2})/

      contents = @place.text_content.split(regexp).map do |part|
        if part.match(regexp)
          "<strong>#{part.gsub(/\*{2}/, '')}</strong>"
        else
          part
        end
      end.join('')

      @pdf.text contents, inline_format: true
      @pdf.move_down 7

      if @place.map_text_content.present?
        content = [
          "<strong>#{t("location.legend")}</strong>",
          @place.map_text_content.strip
        ].join(' ')
        @pdf.text content, inline_format: true
        @pdf.move_down 7
      end
    end

    def plans
      @place.media_placements_images.plans.each do |media|
        @pdf.start_new_page

        @pdf.define_grid(columns: 1, rows: 1)

        @pdf.grid(0, 0).bounding_box do
          @pdf.image open(media.media_item.thumb('1200x1200').url),
                     fit: [bounds.width, bounds.height * 2 / 3]
          @pdf.move_down 14

          if media.title.present?
            @pdf.text media.title
          end

          if media.media_item.copyright.present?
            @pdf.move_down 7 if media.title.present?
            @pdf.text media.media_item.copyright,
                      color: '999999'
          end
        end
      end
    end

    def images
      @place.media_placements_images.not_plans.offset(1).each_slice(2) do |slice|
        @pdf.start_new_page

        @pdf.define_grid(columns: 1, rows: 2)

        slice.each_with_index do |media, index|
          next if media.blank?
          @pdf.grid(index, 0).bounding_box do
            @pdf.image open(media.media_item.thumb('1200x1200').url),
                       fit: [bounds.width, bounds.height * 2 / 3]
            @pdf.move_down 14

            if media.title.present?
              @pdf.text media.title
            end

            if media.media_item.copyright.present?
              @pdf.move_down 2 if media.title.present?
              @pdf.text media.media_item.copyright,
                        color: '999999'
            end
          end
        end
      end
    end

    def page_headers_and_footers
      @pdf.number_pages I18n.t('place_printer.title'),
                        at: [0, bounds.top + 30]

      @pdf.number_pages @place_url,
                        at: [0, 0],
                        size: 8

      @pdf.number_pages I18n.t('place_printer.page_numbers'),
                        at: [0, bounds.top + 30],
                        align: :right
    end

    def bounds
      @pdf.bounds
    end
end
