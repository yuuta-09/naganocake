class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # アソシエーション
  has_many :addresses,  dependent: :destroy
  has_many :cart_items, dependent: :destroy

  # バリデーション
  validates :last_name,        presence: true, length: {maximum: 20}
  validates :first_name,       presence: true, length: {maximum: 20}
  validates :last_name_kana,   presence: true, length: {maximum: 20}
  validates :first_name_kana,  presence: true, length: {maximum: 20}
  validates :postal_code,      presence: true, length: {minimum: 4, maximum: 9}
  validates :address,          presence: true, length: {maximum: 50}
  validates :telephone_number, presence: true, length: {minimum: 10, maximum: 15}
  
  # フルネームを取得するメソッド
  def get_fullname(separator="")
    return self.last_name + separator.to_s + self.first_name
  end

  def get_fullname_kana(separator="")
    return self.last_name_kana + separator.to_s + self.first_name_kana
  end

  # 会員ステータス(有効/無効)の文字を取得するメソッド
  def get_status_str
    return self.is_active ? '有効' : '無効'
  end

  # 会員ステータスに応じたビューのclass名の取得をするためのメソッド
  def get_status_class
    return self.is_active ? 'text-success' : 'text-secondary'
  end
end
