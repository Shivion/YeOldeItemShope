class Item < ApplicationRecord
  has_many :category_item
  has_many :order_item
end
