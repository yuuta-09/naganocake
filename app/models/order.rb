class Order < ApplicationRecord
  # アソシエーション
  has_many :order_details, dependent: :destroy
end
