class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!  # Customerコントローラのすべてのアクションは顧客としてログイン済みの時のみつかえる

  def show
  end

  def edit
  end
end
