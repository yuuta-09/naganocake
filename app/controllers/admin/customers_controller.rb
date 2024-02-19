class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :define_customer,     except: [:index]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def define_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    keys = [
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number,
      :email,
      :is_active
    ]
    params.require(:customer).permit(keys)
  end
end
