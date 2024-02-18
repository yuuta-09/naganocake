class Item < ApplicationRecord
  # 画像投稿のための設定
  has_one_attached :image

  # アソシエーションの設定
  belongs_to :genre

  # バリデーションの設定
  validates :name,          presence: true, length: {maximum: 255}
  validates :introduction,  presence: true, length: {maximum: 255}
  validates :price,         presence: true
  validates :genre_id,      presence: true
  validates :is_active,     inclusion: [true, false] # presence trueだとfalseの時に空と認識される

  def get_status
    return is_active ? "販売中" : "販売停止中"
  end

  def get_status_class
    return is_active ? "text-success" : "text-secondary"
  end
end
