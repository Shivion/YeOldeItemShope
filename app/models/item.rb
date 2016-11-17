class Item < ApplicationRecord
  has_many :category_item
  has_many :order_item
  has_many :orders, :through => :order_item
  has_many :categories, :through => :category_item

  validates :name, :description, :price, :stock, :percentage_off, presence: true
  validates :percentage_off, numericality: { :less_than_or_equal_to => 100}
  validates :price, :stock, :percentage_off, numericality: {:greater_than_or_equal_to => 0}
end
