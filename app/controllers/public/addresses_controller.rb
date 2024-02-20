class Public::AddressesController < ApplicationController
  before_action :authenticate_customer! # 全てのアクションは顧客としてのログインが必要


  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer = current_customer
    if @address.save 
      redirect_to(addresses_path)
    else
      @addresses = current_customer.addresses
      render(:index)
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params) ? redirect_to(addresses_path) : render(:edit)
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
