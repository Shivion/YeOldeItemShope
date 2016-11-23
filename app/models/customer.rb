class Customer < ApplicationRecord
  has_many :order
  belongs_to :user
end
