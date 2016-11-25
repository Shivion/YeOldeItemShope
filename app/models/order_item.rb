class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  validates :item_id, :order_id, presence: true
end
