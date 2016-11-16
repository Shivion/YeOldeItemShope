class Item < ApplicationRecord
  has_many :category_item
  has_many :order_item
  has_many :orders, :through => :order_item
  has_many :categories, :through => :category_item
end
