class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

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
end
