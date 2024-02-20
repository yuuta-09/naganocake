class Address < ApplicationRecord
  belongs_to :customer

  # バリデーション
  validates :postal_code, presence: true, length: {minimum: 4, maximum: 9}
  validates :address,     presence: true, length: {maximum: 50}
  validates :name,        presence: true, length: {maximum: 20}
end
