class Customer < ApplicationRecord
  has_many :order
  belongs_to :user

  validates :email, :address, presence: true
end
