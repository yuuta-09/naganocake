class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  # バリデーション
  validates :price,  presence: true
  validates :amount, presence: true

  # バリデーションなし
  # making_status -> default値があるため設定なし


  ##########################
  ### 金額に関するメソッド ###
  ##########################
  
  # 税込金額を求める
  def get_price_with_tax
    return (price * 1.1).floor
  end

  # 合計金額(税込)を求める
  def get_total_price_with_tax
    return get_price_with_tax * amount
  end
end
