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

  ################################
  ### ステータスに関するメソッド ###
  ################################

  # ステータスの値に応じて適切な文字を返す
  def get_status
    return is_active ? "販売中" : "販売停止中"
  end

  # ビューでテキストの色を設定するbootstrapのクラス名を返す
  def get_status_class
    return is_active ? "text-success" : "text-secondary"
  end

  ##########################
  ### 金額に関するメソッド ###
  ##########################

  # 消費税込みの金額を返す
  def get_price_with_tax
    return price_with_tax = (price * 1.1).floor
  end

  ##########################
  ### 画像に関するメソッド ###
  ##########################

  # 画像が設定されていなかったらデフォルト画像を返す
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  ######################
  #### その他メソッド ###
  ######################

  # 商品名か商品説明がキーワードに一致(部分一致)するItem一覧を返す
  def self.search_by_kwg(kwg)
    name_searched = Item.where("name LIKE '%#{kwg}%'")
    introduction_searched = Item.where("introduction LIKE '%#{kwg}%'")
    
    return name_searched.or(introduction_searched)
  end
end
