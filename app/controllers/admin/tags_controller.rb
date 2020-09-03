class Admin::TagsController < Admin::BaseController
  respond_to :json

  before_action :find_tag, except: [:index,:create]

  # GET /admin/tags
  def index
    @tags = Tag.all
    render json: @tags, each_serializer: Admin::TagSerializer
  end

  # GET /admin/tags/1
  def show
    render json: @tag, serializer: Admin::TagSerializer
  end

  # POST /admin/tags
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, serializer: Admin::TagSerializer
    else
      render json: { errors:  @tag.errors }, status: 422
    end
  end

  # PATCH/PUT /admin/tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag, serializer: Admin::TagSerializer
    else
      render json: { errors:  @tag.errors }, status: 422
    end
  end

  # DELETE /admin/tags/1
  def destroy
    @tag.destroy
    head :no_content
  end

  private

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name,:era,:title_cs,:title_en)
  end
end
