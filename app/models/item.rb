class Item < ApplicationRecord
  # 画像投稿のための設定
  has_one_attached :image

  # アソシエーションの設定
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  # バリデーションの設定
  validates :name,          presence: true, length: {maximum: 255}
  validates :introduction,  presence: true, length: {maximum: 255}
  validates :price,         presence: true
  validates :genre_id,      presence: true
  validates :is_active,     inclusion: [true, false] # presence trueだとfalseの時に空と認識される

  # ステータスに関するメソッド
  def get_status
    return is_active ? "販売中" : "販売停止中"
  end

  def get_status_class
    return is_active ? "text-success" : "text-secondary"
  end

  # 値段に関するメソッド
  def get_price
    return price.to_s(:delimited)
  end

  def get_price_with_tax
    price_with_tax = (price + price * 0.1).floor
    return price_with_tax.to_s(:delimited)
  end

  # 画像に関するメソッド
  def get_image(width=100, height=100)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # 検索に関するメソッド
  def self.search_by_kwg(kwg)
    name_searched = Item.where("name LIKE '%#{kwg}%'")
    introduction_searched = Item.where("introduction LIKE '%#{kwg}%'")
    
    return name_searched.or(introduction_searched)
  end
end
