class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!                # 管理者としてのログインとしなければadmin/customersの機能は使用不可
  before_action :define_customer, except: [:index]  # index以外のアクションでcustomerを定義

  def index
    # kaminariによるページネーション(データ10個取得)
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

  # urlに入っている:idに基づいてcustomerを定義する
  def define_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    # 許可する値を格納した変数
    keys = [
            :last_name,        :first_name,
            :last_name_kana,   :first_name_kana,
            :postal_code,      :address,
            :telephone_number, :email,
            :is_active
          ]

    # formからcustomerに関するデータで受け取っていい値を定義
    params.require(:customer).permit(keys)
  end
end
