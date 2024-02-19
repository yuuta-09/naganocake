class Public::AddressesController < ApplicationController
  before_action :authenticate_customer! # 全てのアクションは顧客としてのログインが必要


  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    @address.customer = current_customer
    if @address.save 
      redirect_to(addresses_path)
    else
      @addresses = Address.all
      render(:index)
    end
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
