class CategoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :category

  validates :category_id, :name_id, presence: true
end
