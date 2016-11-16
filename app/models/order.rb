class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_item
  has_many :items, :through => :order_item
end
