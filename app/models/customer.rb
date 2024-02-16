class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  # フルネームを取得するメソッド
  def get_fullname(separator="")
    return self.last_name + separator.to_s + self.first_name
  end

  def get_fullname_kana(separator="")
    return self.last_name_kana + separator.to_s + self.first_name_kana
  end
end
