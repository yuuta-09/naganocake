class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!  # Customerコントローラのすべてのアクションは顧客としてログイン済みの時のみつかえる
  before_action :define_current_customer    # ログイン中の顧客をインスタンス変数に渡す

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_active: false)
    sign_out @customer
    redirect_to root_path
  end

  private

  def customer_params
    keys = [
      :last_name,        :first_name,
      :last_name_kana,   :first_name_kana,
      :postal_code,      :address,
      :telephone_number, :email
    ]

    params.require(:customer).permit(keys)
  end

  def define_current_customer
    @customer = current_customer
  end
end
