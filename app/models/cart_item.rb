class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true

  # カート内商品の合計金額を求めるメソッド
  def get_total_money
    total_money = (item.price + item.price*0.1) * amount
    return total_money.floor()
  end

  # カート内商品のすべての商品の合計金額を求めるメソッド
  def self.get_total_payment(cart_items)
    total_payment = 0
    for cart_item in cart_items do
      total_payment += cart_item.get_total_money
    end

    return total_payment
  end
end
