class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  # バリデーション
  validates :price,         presence: true
  validates :amount,        presence: true
  validates :making_status, presence: true


  # enumのmaking_statusのための変数
  UNABLE_TO_START_NUM = 0
  WAITING_FOR_PRODUCTION_NUM = 1
  IN_PRODUCTION_NUM = 2
  PRODUCTION_COMPLETE_NUM = 3

  # enumの設定
  enum making_status: {
    unable_to_start:        UNABLE_TO_START_NUM,        # 着手不可
    waiting_for_production: WAITING_FOR_PRODUCTION_NUM, # 制作待ち
    in_production:          IN_PRODUCTION_NUM,          # 製作中
    production_complete:    PRODUCTION_COMPLETE_NUM,    # 製作完了
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
