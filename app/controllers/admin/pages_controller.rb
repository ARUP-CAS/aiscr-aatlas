class Admin::PagesController < Admin::BaseController
  respond_to :json

  before_action :find_page, except: [:index,:create]

  # GET /admin/pages
  def index
    @pages = pages.includes(:media_items,:media_placements,:tags).all
    render json: @pages, each_serializer: serializer
  end

  # GET /admin/pages/1
  def show
    render json: @page, serializer: serializer
  end

  # POST /admin/pages
  def create
    @page = pages.new(page_params)
    if @page.save
      render json: @page, serializer: serializer
    else
      render json: { errors:  @page.errors }, status: 422
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @page.update(page_params)
      render json: @page, serializer: serializer
    else
      render json: { errors:  @page.errors }, status: 422
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @page.destroy
    head :no_content
  end

  private

  def find_page
    @page = pages.find(params[:id])
  end

  def permitted_attributes
    [ :title_cs, :title_en, :subtitle_cs, :subtitle_en, :text_content_en, :text_content_cs,
     :map_text_content_en, :map_text_content_cs, :media_placements_count,
     :slug, :qr_id, :latitude, :longitude, :geo_coordinates, :address_cs, :address_en, :era_cs, :era_en, :tag_list, { :tag_ids => [] } ]
  end

  def page_params
    p = params_require
    p.permit(*permitted_attributes)
  end
end
