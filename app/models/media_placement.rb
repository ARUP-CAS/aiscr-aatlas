class MediaPlacement < ActiveRecord::Base
  belongs_to :page, counter_cache: true
  belongs_to :media_item
  translates :title
  acts_as_list scope: :page

  accepts_nested_attributes_for :media_item

  scope :not_plans, -> { where('not is_plan or is_plan is null') }
  scope :plans, -> { where(is_plan: true) }

  before_create do
    self.title_en = media_item.default_title
    self.title_cs = media_item.default_title
  end
end
