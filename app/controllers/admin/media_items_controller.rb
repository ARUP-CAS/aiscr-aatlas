class Admin::MediaItemsController < Admin::BaseController
  respond_to :json

  before_action :find_media_item, except: [:index,:create]

  # GET /admin/media_items
  def index
    @media_items = items.all
    render json: @media_items, each_serializer: Admin::MediaItemSerializer
  end

  # GET /admin/media_items/1
  def show
    render json: @media_item, serializer: Admin::MediaItemSerializer
  end

  # POST /admin/media_items
  def create
    @media_item = items.new(media_item_params)

    if @media_item.save
      if page = @media_item.pages.first
        render json: Admin::PageSerializer.new(page)
      else
        render json: @media_item, serializer: Admin::MediaItemSerializer
      end
    else
      render json: { errors:  @media_item.errors }, status: 422
    end
  end

  # PATCH/PUT /admin/media_items/1
  def update
    if @media_item.update(media_item_params)
      render json: @media_item, serializer: Admin::MediaItemSerializer
    else
      render json: { errors:  @media_item.errors }, status: 422
    end
  end

  # DELETE /admin/media_items/1
  def destroy
    @media_item.destroy
    head :no_content
  end

  private

  def find_media_item
    @media_item = items.find(params[:id])
  end

  def items
    type = params.delete(:type) || params[:media_item].try(:delete,:type)
    case type.try(:downcase)
    when 'video' then Video
    when 'image' then Image
    else Document
    end
  end

  def media_item_params
    params.require(:media_item).permit(:copyright_cs, :copyright_en,:source_url,:cover_url,page_ids: [])
  end

end
