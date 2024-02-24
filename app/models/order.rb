class Order < ApplicationRecord
  # 定数
  SHIPPING_COST = 800
  
  # payment_methodのための定数
  CREDIT_CARD_NUM = 0
  TRANSFER_NUM = 1
  
  # アソシエーション
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  
  # enumの設定
  enum payment_method: { credit_card: CREDIT_CARD_NUM, transfer: TRANSFER_NUM }

  # バリデーションの設定
  validates :postal_code,    presence: true, length: {minimum: 4, maximum: 9}
  validates :address,        presence: true, length: {maximum: 50}
  validates :name,           presence: true, length: {maximum: 20}
  validates :shipping_cost,  presence: true
  validates :total_payment,  presence: true
  validates :payment_method, presence: true
  validates :status,         presence: true
  
  
  #########################
  ### enum関連のメソッド ###
  #########################
  def self.credit_card_key
    self.payment_methods.key(CREDIT_CARD_NUM)
  end
  
  def self.transfer_key
    self.payment_methods.key(TRANSFER_NUM)
  end
  
  def self.credit_card
    self.payment_methods_i18n[:credit_card]
  end
  
  def self.transfer
    self.payment_methods_i18n[:transfer]
  end

  
  #########################
  ### 定数取得のメソッド ###
  #########################
  def self.shipping_cost
    return SHIPPING_COST
  end


  ####################################
  ### order_detailsに関するメソッド ###
  ####################################
  
  # カート内商品すべてをorder_detailsとして保存
  def create_order_details(cart_items)
    OrderDetail.transaction do
      cart_items.each do |cart_item|
        order_details = OrderDetail.new
        order_details.order = self
        order_details.item = cart_item.item
        order_details.price = cart_item.item.price
        order_details.amount = cart_item.amount
        order_details.save!
      end
    end

    cart_items.destroy_all
  end


  ############################
  ### 配送先に関するメソッド ###
  ############################

  # 渡されたorderモデルの住所を登録し、登録したAddressを返す
  # 新しいおお届け先の場合はAddressを登録
  def set_address(params)
    # ログインしているユーザの住所
    if params[:select_address] == "self"
      self.postal_code = customer.postal_code
      self.address = customer.address
      self.name = customer.get_fullname 
    # 顧客によって登録された住所
    elsif params[:select_address] == "registered"
      address = customer.addresses.find(params[:address_id])
      self.postal_code = address.postal_code
      self.address = address.address
      self.name = address.name
    else
      # 新しい登録先の場合はorderに対して何もしない。
      # Order.new(order_params)の際にorder_paramsにデータが既に入っているため。
    end

    # 何も返さない
    return nil
  end

  # '〒{郵便番号} {住所} {宛先}'のフォーマットで表示
  def display_address
    '〒' + ' ' + postal_code + ' ' + address + ' ' + name
  end
end
