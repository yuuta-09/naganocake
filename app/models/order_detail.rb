class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  # バリデーション
  validates :price,  presence: true
  validates :amount, presence: true

  # バリデーションなし
  # making_status -> default値があるため設定なし

  # enumの設定
  enum making_status: {
    unable_to_start:        0 # 着手不可
    waiting_for_production: 1 # 制作待ち
    in_production:          2 # 製作中
    production_complete:    3 # 製作完了
  }


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
