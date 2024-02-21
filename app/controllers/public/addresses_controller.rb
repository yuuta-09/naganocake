class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!                     # 全てのアクションは顧客としてのログインが必要
  before_action :define_address, except: [:index, :create]  # indexとcreate以外のアクションではurlのidをもとに一つのAddressを定義


  def index
    @addresses = current_customer.addresses # 一覧表示に使用するログイン中のユーザの全ての配送先アドレスが入った変数
    @address = Address.new                  # 新規作成フォームに使用する新しいAddressが入った変数
  end

  def edit
  end

  def create
    @address = Address.new(address_params)  # フォームで送られてきたデータに基づいてAddressを新規作成 
    @address.customer = current_customer    # 新規作成するAddressはログイン中のユーザと紐づけ
    if @address.save 
      redirect_to(addresses_path)
    else
      @addresses = current_customer.addresses  # render先で使用するログイン中のユーザの配送先アドレス一覧
      render(:index)
    end
  end

  def update
    @address.update(address_params) ? redirect_to(addresses_path) : render(:edit)
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private

  # フォームから送られるaddressに関する情報の許可する値の設定
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  # urlの:idをもとに1つのaddressを取得する
  def define_address
    @address = Address.find(params[:id])
  end
end
