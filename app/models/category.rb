class Category < ApplicationRecord
  has_many :category_item
  has_many :items, :through => :category_item
end
